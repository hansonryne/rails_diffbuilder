# frozen_string_literal: true

class CreateGrepFromSelectionReflex < ApplicationReflex
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
      "Nice"
    end
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
