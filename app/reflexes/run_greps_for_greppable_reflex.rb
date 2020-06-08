# frozen_string_literal: true

class RunGrepsForGreppableReflex < ApplicationReflex
  def execute
    @grep_status = :running
    wait_for_it(:success) do
      @repo = Repository.find(element.dataset[:repository])

      job = RunAllGrepsJob.perform_later(@repo)
      status = ActiveJob::Status.get(job)
      while not status.completed? do
        sleep 1
      end
    end
  end

  def success(response)
    @grep_status = :complete
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
