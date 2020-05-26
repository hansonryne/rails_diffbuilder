class Grep < ApplicationRecord
  belongs_to :greppable, polymorphic: true
  belongs_to :source_rule, class_name: "Rule", foreign_key: "rule_id", optional: true
  has_many :grep_results, dependent: :destroy

  validate :custom_or_derived
  validates :source_rule, presence: true, allow_blank: true
  def custom_or_derived
    errors.add(:base, "A rule must either have a valid source rule or be marked custom.") unless custom ^ source_rule.present?
  end

end
