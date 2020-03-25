class Repository < ApplicationRecord
  has_many :reviews, :dependent => :destroy
end
