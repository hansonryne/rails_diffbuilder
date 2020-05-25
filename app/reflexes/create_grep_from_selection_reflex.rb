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
    @greps_status = :running
    @new_grep = Grep.create(rule_id: element.dataset[:rule],
                            search_value: element.dataset[:selection],
                            greppable_id: element.dataset[:greppable],
                            greppable_type: element.dataset[:type],
                            custom: false
                           )
    @sr_message = "Added"
    wait_for_it(:success) do
      sleep 10
      "Nice"
    end
  end
=begin
    if element.dataset[:repository]
      @new_grep = Grep.create(rule_id: element.dataset[:rule],
                              search_value: element.dataset[:selection],
                              repository_id: element.dataset[:repository],
                              custom: false
                             )
      @sr_message = "Added"
      wait_for_it(:success) do
        sleep 10
        "Nice"
      end
    elsif element.dataset[:review]
      @new_grep = Grep.create(rule_id: element.dataset[:rule],
                              search_value: element.dataset[:selection],
                              review_id: element.dataset[:review],
                              custom: false
                             )
      @sr_message = "Added"
      wait_for_it(:success) do
        sleep 10
        "Nice"
      end
    else
=end

  def success(response)
    Grep.last.update(results: "info")
    @greps_status = :ready
    @greps_response = response
  end

  def wait_for_it(target)
    if block_given?
      Thread.new do
        @channel.receive({
          "target" => "#{self.class}##{target}",
          "args" => [yield],
          "url" => url,
          "attrs" => element.attributes.to_s,
          "selectors" => selectors,
        })
      end
    end
  end
end
