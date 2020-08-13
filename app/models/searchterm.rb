class Searchterm < ApplicationRecord
  has_many :checklists_searchterms, dependent: :destroy
  has_many :checklists, through: :checklists_searchterms

  has_one :grep, dependent: :destroy

  belongs_to :rule, optional: true

  validate :custom_or_derived

  #validates :value, uniqueness: { scope: [:rule_id] }

  def custom_or_derived
    errors.add(:base, "A searchterm must either have a valid source rule or be marked custom.") unless custom ^ rule.present?
  end
end
