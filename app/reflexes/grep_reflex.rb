# frozen_string_literal: true

class GrepReflex < ApplicationReflex
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
  def create_custom
    puts "here"
    puts "here"
    puts "here"
    puts "here"
    puts "here"
    safe_params = grep_params
    @new_search = Searchterm.new(
      value: safe_params[:search_value],
      custom: true
    )
    puts @new_search.inspect

    if @new_search.save!
    @new_grep = Grep.new(
      search_value: safe_params[:search_value],
      searchterm_id: @new_search.id,
      greppable_id: safe_params[:greppable_id],
      greppable_type: safe_params[:greppable_type],
      custom: true,
      rule_id: "",
      results: "Run me"
    )

     if @new_grep.save
     else
      @new_search.destroy
     end
    end
  end

  def grep_params
    params.require(:grep).permit(:search_value, :greppable_id, :greppable_type)
  end
end
