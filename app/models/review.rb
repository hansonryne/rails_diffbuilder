class Review < ApplicationRecord
  belongs_to :repository
  has_many :diffs, :dependent => :destroy

  validates :start_date, :presence => true
  validates :owner, :presence => true
  validates :old_commit, :presence => true
  validates :new_commit, :presence => true
  validates :new_commit, exclusion: { in: ->(review) { [review.old_commit] }, message: "and old commit must be different" }

  def get_review_status(review)
    if review.diffs.count == 0
      return "Nothing"
    else
      total_diffs = review.diffs.count.to_f
    end
    completed = review.diffs.select { |d| d.status.in? ["Complete", "Vulnerable", "Ignored"] }.count
    (completed / total_diffs * 100).round.to_s + '%' + " (#{completed}/#{total_diffs.round.to_s})"
  end

end
