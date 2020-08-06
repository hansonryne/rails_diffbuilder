class ChecklistsLanguage < ApplicationRecord
  belongs_to :checklist
  belongs_to :language
end
