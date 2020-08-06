# frozen_string_literal: true

class SearchtermReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com
  def build
    @searchterm = Searchterm.new(
      value: element.dataset.selection,
      rule_id: element.dataset.rule
    )

    if @searchterm.save
    else
      @searchterm = Searchterm.find_by(value: element.dataset.selection, rule_id: element.dataset.rule)
    end

    Grep.create(
      rule_id: element.dataset.rule,
      search_value: @searchterm.value,
      searchterm_id: @searchterm.id,
      greppable_id: element.dataset.greppable,
      greppable_type: element.dataset.type,
      custom: false,
      results: "Run me"
     )
  end

  def delete
    # If searchterm is saved to a checklist, only delete the grep.
    unless ChecklistsSearchterm.find_by(searchterm_id: element.dataset.searchterm)
      Searchterm.find(element.dataset.searchterm).destroy
    else
      Grep.find_by(searchterm_id: element.dataset.searchterm).destroy
    end
  end
end
