class DiffsController < ApplicationController
  before_action :set_diff, only: [:show, :edit, :update, :destroy]

  # GET /diffs
  # GET /diffs.json
  def index
    @diffs = Diff.all
  end

  # GET /diffs/1
  # GET /diffs/1.json
  def show
    @repository = @diff.review.repository
    @difftext = Git.open(@repository.get_secret_path).diff(@diff.review.old_commit, @diff.review.new_commit).path(@diff.path).to_s
    @diff ||= Diff.find(params[:id])
  end

  # GET /diffs/new
  def new
    @diff = Diff.new
  end

  # GET /diffs/1/edit
  def edit
  end

  # POST /diffs
  # POST /diffs.json
  def create
    @diff = Diff.new(diff_params)

    respond_to do |format|
      if @diff.save
        format.html { redirect_to @diff, notice: 'Diff was successfully created.' }
        format.json { render :show, status: :created, location: @diff }
      else
        format.html { render :new }
        format.json { render json: @diff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diffs/1
  # PATCH/PUT /diffs/1.json
  def update
    @status = diff_params[:status]
    respond_to do |format|
      if @diff.update(diff_params)
        redirect_status = ["Complete", "Ignored", "Vulnerable"]
        if @status.in? redirect_status
          format.html { redirect_to @diff.review, notice: "Diff was marked #{@status}." }
        end
        format.html { redirect_to @diff, notice: 'Diff was successfully updated.' }
        format.json { render :show, status: :ok, location: @diff }
      else
        format.html { redirect_to @diff.review, notice: 'An error occurred - please try again.' }
        format.json { render json: @diff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diffs/1
  # DELETE /diffs/1.json
  def destroy
    @diff.destroy
    respond_to do |format|
      format.html { redirect_to diffs_url, notice: 'Diff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_diff
    @diff = Diff.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def diff_params
    params.require(:diff).permit(:review_id, :status, :notes, :path, :reason)
  end
end
