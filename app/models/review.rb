class Review < ApplicationRecord
  belongs_to :repository
  has_many :diffs, :dependent => :destroy
  has_many :greps, :dependent => :destroy

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

end
