class Diff < ApplicationRecord
  validates :status, inclusion: { in: ["Not-Reviewed", "Ignored", "Vulnerable", "Complete"], message: "Status is not one of the permitted values" }

  belongs_to :review

  attribute :status, :string, default: "Not-Reviewed"
end
