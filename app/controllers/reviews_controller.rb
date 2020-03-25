class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review.status = get_review_status(@review)
  end

  # GET /reviews/new
  def new
    if params[:repo_id]
      @review = Review.new
      @review.repository = Repository.find(params[:repo_id])
      begin
        @commits = get_repo_commits(@review)
      rescue ArgumentError => e
        flash[:alert] = "Error: Git repository does not exist."
        redirect_to repository_path(@review.repository.id)      
      end
    else 
      redirect_to(select_repository_path)
    end
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        @changed_files = Git.open(get_secret_path(@review.repository)).diff(@review.old_commit, @review.new_commit).name_status
          @changed_files.each do |file|
            pp file
            case file[1]
            when "A"
              Diff.create :path => file[0], :review_id => @review.id, :reason => "Added"
            when "M"
              Diff.create :path => file[0], :review_id => @review.id, :reason => "Modified"
            when "C"
              Diff.create :path => file[0], :review_id => @review.id, :reason => "Copied"
            when "R"
              Diff.create :path => file[0], :review_id => @review.id, :reason => "Renamed"
            when "D"
              Diff.create :path => file[0], :review_id => @review.id, :reason => "Deleted"
            when "U"
              Diff.create :path => file[0], :review_id => @review.id, :reason => "Unmerged"
            end
          end
          format.html { redirect_to @review, notice: 'Review was successfully created.' }
          format.json { render :show, status: :created, location: @review }
      else
        @commits = get_repo_commits(@review)
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
  def get_secret_path(repository)
    Rails.root.join("storage", "repositories", repository.secret_path)
  end

  def get_repo_commits(review)
    @commits = Git.open(get_secret_path(review.repository)).log
  end

  def get_review_status(review)
    total_diffs = review.diffs.count.to_f
    completed = review.diffs.select { |d| d.status.in? ["Complete", "Vulnerable", "Ignored"] }.count
    (completed / total_diffs * 100).round.to_s + '%' + " (#{completed}/#{total_diffs.round.to_s})"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:repository_id, :start_date, :status, :owner, :old_commit, :new_commit)
  end
end
