class Searchterm < ApplicationRecord
  has_many :checklists, through: :checklists_searchterms
  belongs_to :rule
end
