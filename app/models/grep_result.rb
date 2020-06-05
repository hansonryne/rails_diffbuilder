class GrepResult < ApplicationRecord
  belongs_to :grep

  validates :grep_id, :uniqueness => {:scope => [:filename, :line_number]}
end
