class Checklist < ApplicationRecord
    has_many :checklists_searchterms, dependent: :destroy
    has_many :searchterms, through: :checklists_searchterms

    has_many :checklists_languages, dependent: :destroy
    has_many :languages, through: :checklists_languages

    validates :name, presence: true
end
