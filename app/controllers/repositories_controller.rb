class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]

  # GET /repositories
  # GET /repositories.json
  def index
    @repositories = Repository.all
  end

  # GET /repositories/1
  # GET /repositories/1.json
  def show
  end

  # GET /repositories/new
  def new
    @repository = Repository.new
  end

  # GET /repositories/1/edit
  def edit
  end

  # POST /repositories
  # POST /repositories.json
  def create
    @repository = Repository.new(repository_params)
    @uri = URI(@repository.repo_location)
    @repository.secret_path = SecureRandom.hex.to_s + @uri.path.split("/").last.to_s
    Git.clone(@uri, @repository.secret_path, :path => Rails.root.join("storage", "repositories"))

    respond_to do |format|
      if @repository.save
        format.html { redirect_to @repository, notice: 'Repository was successfully created.' }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { render :new }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repositories/1
  # PATCH/PUT /repositories/1.json
  def update
    @git = Git.open(Rails.root.join("storage", "repositories", @repository.secret_path))
    @git.pull

    respond_to do |format|
      if @repository.update(update_params)
        format.html { redirect_to @repository, notice: 'Repository was successfully updated.' }
        format.json { render :show, status: :ok, location: @repository }
      else
        format.html { render :edit }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1
  # DELETE /repositories/1.json
  def destroy
    @folder_to_delete = @repository.get_secret_path
    if @repository.destroy
      FileUtils.rm_rf(@folder_to_delete, :secure =>true)
      puts @path
      respond_to do |format|
        format.html { redirect_to repositories_url, notice: 'Repository was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
        format.html { redirect_to @repository, notice: 'Repository was not destroyed.' }
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Repository.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repository_params
      params.require(:repository).permit(:name, :project, :repo_location)
    end

    def update_params
      params.require(:repository).permit(:secret_path)
    end

  end
