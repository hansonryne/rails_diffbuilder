class Review < ApplicationRecord
  belongs_to :repository
  has_many :diffs, :dependent => :destroy
end
