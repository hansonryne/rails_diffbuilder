# frozen_string_literal: true

class ChecklistReflex < ApplicationReflex
  def save_checklist
    puts "REPO #{element.dataset.repository}"
    g = Grep.where(greppable_id: element.dataset.repository)
    puts "adfasdfasdfasdfasdfasdfa"
    pp g.to_a
  end

  def load_checklist
  end
end
