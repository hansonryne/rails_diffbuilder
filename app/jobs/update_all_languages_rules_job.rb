class UpdateAllLanguagesJob < ApplicationJob
  include ActiveJob::Status
  queue_as :default

  def perform
    puts self.job_id
    puts "Upadaing all the languages"


  end
end
