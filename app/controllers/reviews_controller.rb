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
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @review.repository = Repository.find(params[:repo_id])
    @commits = Git.open(@review.repository.repo_location).log
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @errors = @review.errors.to_a
    pp @errors

    @changed_files = Git.open(@review.repository.repo_location).diff(@review.old_commit, @review.new_commit).name_status
    pp @changed_files

    respond_to do |format|
      if @review.save
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
        flash[:error] = @errors
        pp @errors
        format.html { redirect_to new_review_path(repo_id: @review.repository.id) }
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
