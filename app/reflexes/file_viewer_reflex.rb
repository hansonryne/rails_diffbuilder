# frozen_string_literal: true

class FileViewerReflex < ApplicationReflex
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
  def show_file
    @file_content = ["<div class='w-2/3 font-bold text-teal-700 text-xl mb-4'>Loading file...</div>".html_safe]
    
    result_line = element.dataset.line.to_i
    range = 10
    
    secret_path = Repository.find(element.dataset.repository).secret_path
    file = Rails.root.join("storage", "repositories", secret_path, element.dataset.filename)
    
    @file_content = []

    File.foreach(file).with_index do |line, index|
      if index + 1 > result_line - range and index + 1 < result_line + range
        if result_line == index + 1
          @file_content << "<span class='bg-red-500'>".html_safe + "#{index + 1}: \t #{line}" + "</span>".html_safe
        else
          @file_content << "#{index + 1}: \t #{line}"
        end
      end
    end

  end

  def reset_preview
    @file_content = ["<div class='w-2/3 font-bold text-teal-700 text-xl mb-4'>Loading file...</div>".html_safe]
  end
end
