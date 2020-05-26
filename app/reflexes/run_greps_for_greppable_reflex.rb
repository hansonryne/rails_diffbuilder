# frozen_string_literal: true

class RunGrepsForGreppableReflex < ApplicationReflex
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
  def execute
    @greps_status = :running

    @repo = Repository.find(element.dataset[:repository])
    @repo.greps.each do |g|
      GrepResult.destroy_by(grep_id: g.id)
    end
    results = @repo.run_all_greps
    puts '-----------'
    puts results
    results.each do |result|
      @new_grep_res = GrepResult.new(filename: result[:filename], line_number: result[:line_number], grep_id: result[:grep_id])
      @new_grep_res.save
    end
    @greps_status = :ready
  end

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
