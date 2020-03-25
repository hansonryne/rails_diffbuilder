json.extract! repository, :id, :name, :project, :repo_location, :local_copy, :created_at, :updated_at
json.url repository_url(repository, format: :json)
