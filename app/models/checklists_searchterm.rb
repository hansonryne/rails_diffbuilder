class ChecklistsSearchterm < ApplicationRecord
  belongs_to :checklist
  belongs_to :searchterm
end
