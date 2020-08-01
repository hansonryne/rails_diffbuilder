# frozen_string_literal: true

class UpdateLanguageRulesReflex < ApplicationReflex
  def execute
    @lang_update_status = :running
    @lang = element.dataset[:language] ? [] << Language.find(element.dataset[:language]) : Language.all.first(2)
    #TESTING @lang = element.dataset[:language] ? [] << Language.find(element.dataset[:language]) : Language.where(name: %w[XML CSS])
    wait_for_it(:success) do
      jobs = []
      @lang.each do |l|
        puts l.name
        job_id = UpdateOneLanguageRulesJob.perform_later(l)
        jobs << { id: job_id, language: l, complete: ActiveJob::Status.get(job_id).completed? }
      end

      until jobs.empty?
        jobs.each_with_index do |j, i|
          if j[:complete] == true
            jobs.delete_at(i)
          else
            j[:complete] = ActiveJob::Status.get(j[:id]).completed?
          end
        end
        sleep 1
      end
    end
  end

  def success(_response)
    @lang_update_status = :complete
  end

  def wait_for_it(target)
    if block_given?
      Thread.new do
        @channel.receive({
          'target' => "#{self.class}##{target}",
          'args' => [yield],
          'url' => url,
          'attrs' => element.attributes.to_s,
          'selectors' => selectors
          })
      end
    end
  end
end