class RepoLang < ApplicationRecord
  belongs_to :repository
  belongs_to :language
end
