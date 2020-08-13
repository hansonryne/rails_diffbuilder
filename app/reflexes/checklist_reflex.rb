# frozen_string_literal: true

class ChecklistReflex < ApplicationReflex
  def save_checklist
    checklist = Checklist.new(name: element.dataset.name)
    greps = Grep.where(greppable_id: element.dataset.greppable_id)
    if checklist.save
      greps.each do |grep|
        if grep.custom != true
        language = Rule.find(grep.rule_id).language
        checklist.languages << language unless checklist.languages.include? language
        end
        searchterm = Searchterm.find(grep.searchterm_id)
        checklist.searchterms << searchterm
      end
    else
      Rails.logger.info(checklist.errors.inspect)
    end
  end

  def load_checklist
    if element.dataset.type == "Repository"
      greppable = Repository.find(element.dataset.greppable_id)
      type = "Repository"
    elsif element.dataset.type == "Review"
      greppable = Review.find(element.dataset.greppable_id)
      type = "Review"
    end


    if element.dataset.checklist == 0
      return
    elsif element.dataset.type == "Repository" or element.dataset.type == "Review"
      searchterms = Checklist.find(element.dataset.checklist).searchterms

      Grep.destroy(Grep.where(greppable_id: greppable, greppable_type: type).pluck :id)

      searchterms.each do |s|
        @new_grep = Grep.new(searchterm_id: s.id,
          search_value: s.value,
          rule_id: s.custom != true ? s.rule_id : nil,
          greppable_type: element.dataset.type,
          greppable_id: greppable.id,
          results: "Run me",
          custom: s.custom != true ? false : true
        )
      end
    else
      puts "Not a valid greppable type!"
    end


  end
end
