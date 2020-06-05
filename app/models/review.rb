class Review < ApplicationRecord
  include Greppable

  belongs_to :repository
  has_many :diffs, dependent: :destroy

  validates :start_date, :presence => true
  validates :owner, :presence => true
  validates :old_commit, :presence => true
  validates :new_commit, :presence => true
  validates :new_commit, exclusion: { in: ->(review) { [review.old_commit] }, message: "and old commit must be different" }

  def get_repository
    return Repository.find(self.repository_id)
  end

  def get_status
    if self.diffs.count == 0
      return "Nothing"
    else
      total_diffs = self.diffs.count.to_f
    end
    completed = self.diffs.select { |d| d.status.in? ["Complete", "Vulnerable", "Ignored"] }.count
    (completed / total_diffs * 100).round.to_s + '%' + " (#{completed}/#{total_diffs.round.to_s})"
  end

  def get_changed_files
    changed_files = Git.open(self.repository.get_secret_path).diff(self.old_commit, self.new_commit).name_status
    changed_files.each do |file|
      case file[1]
      when "A"
        Diff.create :path => file[0], :review_id => self.id, :reason => "Added"
      when "M"
        Diff.create :path => file[0], :review_id => self.id, :reason => "Modified"
      when "C"
        Diff.create :path => file[0], :review_id => self.id, :reason => "Copied"
      when "R"
        Diff.create :path => file[0], :review_id => self.id, :reason => "Renamed"
      when "D"
        Diff.create :path => file[0], :review_id => self.id, :reason => "Deleted"
      when "U"
        Diff.create :path => file[0], :review_id => self.id, :reason => "Unmerged"
      end
    end
  end

end
