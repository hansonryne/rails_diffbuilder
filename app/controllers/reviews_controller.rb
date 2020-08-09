class ReviewsController < ApplicationController
  include GreppableController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
    @reviews.each do |r|
      r.status = r.get_status
    end
    @path_revi = request.path.starts_with? '/revi'
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @path_revi = request.path.starts_with? '/revi'
  end

  # GET /reviews/new
  def new
    @grep = Grep.new
    if params[:repo_id]
      @review = Review.new
      @review.repository = Repository.find(params[:repo_id])
      begin
        @commits = @review.repository.get_commits
      rescue ArgumentError => e
        flash[:alert] = "Error: Git repository does not exist."
        redirect_to repository_path(@review.repository.id)      
      end
    else 
      redirect_to(select_repository_path)
    end
    @path_revi = request.path.starts_with? '/revi'
  end

  # GET /reviews/1/edit
  def edit
    @path_revi = request.path.starts_with? '/revi'
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        @changed_files = @review.get_changed_files
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        @commits = @review.repository.get_commits
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:repository_id, :start_date, :status, :owner, :old_commit, :new_commit)
  end
end
