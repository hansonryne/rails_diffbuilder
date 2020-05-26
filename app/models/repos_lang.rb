class ReposLang < ApplicationRecord
  belongs_to :repository
  belongs_to :language
end
