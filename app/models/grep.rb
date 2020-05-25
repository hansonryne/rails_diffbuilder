class Grep < ApplicationRecord
  belongs_to :greppable, polymorphic: true
  #belongs_to :review, optional: true
  #belongs_to :repository, optional: true
  belongs_to :source_rule, class_name: "Rule", foreign_key: "rule_id", optional: true

  validate :custom_or_derived
  validates :source_rule, presence: true, allow_blank: true

=begin
  validate :review_or_repository
  validates :review_id, presence: true, allow_blank: true
  validates :repository_id, presence: true, allow_blank: true


  def review_or_repository
    errors.add(:base, "Either a review or repository must be selected, but not both.") unless review_id.present? ^ repository_id.present?
  end
=end
  def custom_or_derived
    errors.add(:base, "A rule must either have a valid source rule or be marked custom.") unless custom ^ source_rule.present?
  end


end
