# frozen_string_literal: true

class CreateGrepFromSelectionReflex < ApplicationReflex
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
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com
  def make_grep
    if element.dataset[:repository]
      @new_grep = Grep.create(rule_id: element.dataset[:rule],
                           search_value: element.dataset[:selection],
                           repository_id: element.dataset[:repository],
                           custom: false
                          )
      @sr_message = "Sucess"
    elsif element.dataset[:review]
      @new_grep = Grep.create(rule_id: element.dataset[:rule],
                           search_value: element.dataset[:selection],
                           review_id: element.dataset[:review],
                           custom: false
                          )
      @sr_message = "Sucess"
    else
      return @sr_message = "Failed"
    end
  end
end
