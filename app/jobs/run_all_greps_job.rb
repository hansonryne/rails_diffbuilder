class RunAllGrepsJob < ApplicationJob
  include ActiveJob::Status
  queue_as :default

  def perform(repository)
    puts self.job_id
    repo_path = Rails.root.join('storage', 'repositories', repository.secret_path)
    files = repository.get_files_for_grep(repo_path)
    progress.total = files.count


    results = []

    files.each do |file|
      File.foreach(file) do |line|
        repository.greps.each do |grep|
          if line.include?(grep.search_value)
            results << { grep_id: grep.id, filename: "#{file.sub(repo_path.to_s + '/', '')}", line_number: $. }
          end
        end
      end
      progress.increment
    end

    repository.greps.each do |g|
      local_results = results.select {|result| result[:grep_id] == g.id}
      if local_results.present?
        g.update(results: "Found")
        local_results.each do |result|
          @new_grep_res = GrepResult.new(filename: result[:filename], line_number: result[:line_number], grep_id: result[:grep_id])
          @new_grep_res.save
        end
      else
        g.update(results: "No matches found")
      end
    end
  end
end
