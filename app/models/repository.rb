class Repository < ApplicationRecord
  has_many :reviews, :dependent => :destroy

  validates :name, :presence => true
  validates :project, :presence => true
  validates :repo_location, :presence => true
end
