class Review < ApplicationRecord
  belongs_to :repository
  has_many :diffs, :dependent => :destroy

  validates :start_date, :presence => true
  validates :owner, :presence => true
  validates :old_commit, :presence => true
  validates :new_commit, :presence => true
  validates :new_commit, exclusion: { in: ->(review) { [review.old_commit] }, message: "and old commit must be different" }

end
