class Tag < ApplicationRecord
  has_many :rule_tags
  has_many :rules, through: :rule_tags
end
