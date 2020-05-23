class Language < ApplicationRecord
  belongs_to :repository

  has_many :rules

  def build_languages
  end
end
