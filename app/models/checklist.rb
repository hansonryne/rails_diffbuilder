class Checklist < ApplicationRecord
    has_many :searchterms, through: :checklists_searchterms
end
