class Rule < ApplicationRecord
  belongs_to :language

  has_many :rule_tags
  has_many :tags, through: :rule_tags

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
