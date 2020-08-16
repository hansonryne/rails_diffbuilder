class RepositoriesController < ApplicationController
  include GreppableController
  before_action :set_repository, only: [:show, :edit, :update, :destroy, :start_grepping]
  
  # GET /repositories
  # GET /repositories.json
  def index
    @repositories = Repository.all
    @path_repos = request.path.starts_with? '/repos'
  end
  
  def start_grepping
    @repository.run_current_greps
  end
  
  # GET /repositories/1
  # GET /repositories/1.json
  def show
    @languages = []
    @repository.languages.each do |l|
      @languages << Language.includes(rules: [:tags]).find_by(id: l.id)
    end
    @greps ||= @repository.greps
    if Delayed::Job.any?
      @grep_status = :running
    else
      @grep_status ||= :default
    end
    @flagged_files = {}
    @greps.each do |g|
      g.flag_files(@flagged_files)
    end
    @checklists = Checklist.all
    @categories = Rule.distinct.pluck(:category)
    @path_repos = request.path.starts_with? '/repos'
    @new_grep = Grep.new
  end
  
  # GET /repositories/new
  def new
    @repository = Repository.new
    @languages = Language.all.order(:name)
    @path_repos = request.path.starts_with? '/repos'
  end
  
  # GET /repositories/1/edit
  def edit
    @languages = Language.all.order(:name)
    @path_repos = request.path.starts_with? '/repos'
  end
  
  # POST /repositories
  # POST /repositories.json
  def create
    final_params = repository_params
    languages = Language.where(name: repository_params[:languages])
    final_params[:languages] = languages
    
    @repository = Repository.new(final_params)
    @uri = URI(@repository.repo_location)
    @repository.secret_path = SecureRandom.hex.to_s + @uri.path.split("/").last.to_s
    @secret_path_to_clone_to = @repository.secret_path
    
    respond_to do |format|
      if @repository.save
        Git.clone(@uri, @secret_path_to_clone_to, :path => Rails.root.join("storage", "repositories"))
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
    
    final_params = update_params
    if update_params[:languages]
      puts update_params
      languages = Language.where(name: update_params[:languages])
      final_params[:languages] = languages
    end
    
    respond_to do |format|
      if @repository.update(final_params)
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
    params.require(:repository).permit(:name, :project, :repo_location, languages: [])
  end
  
  def update_params
    params.require(:repository).permit(:secret_path, :repo_location, :project, :name, languages: [])
  end
  
end
