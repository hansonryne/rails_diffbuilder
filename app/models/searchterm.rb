class Searchterm < ApplicationRecord
  has_many :checklists_searchterms, dependent: :destroy
  has_many :checklists, through: :checklists_searchterms

  has_one :grep, dependent: :destroy

  belongs_to :rule

  validates :value, uniqueness: { scope: [:rule_id] }
end
