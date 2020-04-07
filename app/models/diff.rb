class Diff < ApplicationRecord
  validates :status, inclusion: { in: ["Incomplete", "Ignored", "Vulnerable", "Complete"], message: "Status is not one of the permitted values" }

  belongs_to :review

  attribute :status, :string, default: "Incomplete"
end
