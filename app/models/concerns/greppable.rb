module Greppable
  extend ActiveSupport::Concern
  included do
    has_many :greps, as: :greppable, dependent: :destroy
  end

  def run_all_greps
    repo_path = Rails.root.join('storage', 'repositories', self.secret_path)
    files = self.get_files_for_grep(repo_path)
    results = []

    files.each do |file|
      File.foreach(file) do |line|
        self.greps.each do |grep|
          if line.include?(grep.search_value)
            results << { grep_id: grep.id, filename: "#{file.sub(repo_path.to_s + '/', '')}", line_number: $. }
          end
        end
      end
    end
    return results
  end

  def get_files_for_grep(secret_path)
    if self.class.to_s == "Repository"
      Dir.glob(secret_path.join('**', '*')).select {|f| File.file?(f)}
    elsif self.class.to_s == "Review"
      return nil
    end
  end
end