class Diff < ApplicationRecord
  validates :status, inclusion: { in: ["Not Reviewed", "Ignored", "Vulnerable", "Complete"], message: "An error has occurred" }

  belongs_to :review

  attribute :status, :string, default: "Not Reviewed"
end
