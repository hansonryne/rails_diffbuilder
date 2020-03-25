class ApplicationController < ActionController::Base
  def get_secret_path(repository)
    Rails.root.join("storage", "repositories", repository.secret_path)
  end
end
