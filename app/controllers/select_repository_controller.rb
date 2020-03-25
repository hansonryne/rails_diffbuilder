class SelectRepositoryController < ApplicationController
  def index
    @repositories = Repository.all
  end
end
