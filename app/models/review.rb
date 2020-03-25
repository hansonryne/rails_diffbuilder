class Review < ApplicationRecord
  belongs_to :repository
  has_many :diffs, :dependent => :destroy

  validates :start_date, :presence => true
  validates :owner, :presence => true
  validates :old_commit, :presence => true
  validates :new_commit, :presence => true
  validates :old_commit, exclusion: { in: ->(review) { [review.new_commit] }, message: "and new commit must be different" }

end
