# frozen_string_literal: true

class CreateGrepFromSelectionReflex < ApplicationReflex
  def make_grep
    @new_grep = Grep.create(rule_id: element.dataset[:rule],
                            search_value: element.dataset[:selection],
                            greppable_id: element.dataset[:greppable],
                            greppable_type: element.dataset[:type],
                            custom: false
                           )
    wait_for_it(:success) do
    end
  end

  def success(response)
    Grep.last.update(results: "Run me.")
  end

  private

  def wait_for_it(target)
    return unless respond_to? target
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
