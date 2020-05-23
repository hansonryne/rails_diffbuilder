class RuleTag < ApplicationRecord
  belongs_to :rule
  belongs_to :tag
end
