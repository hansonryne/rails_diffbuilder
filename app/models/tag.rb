class Tag < ApplicationRecord
  has_many :rule_tags, dependent: :destroy
  has_many :rules, through: :rule_tags

  validates :name, uniqueness: true
end
