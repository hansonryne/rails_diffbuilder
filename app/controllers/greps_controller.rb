class GrepsController < ApplicationController
  before_action :set_grep, only: [:show, :edit, :update, :destroy]

  # GET /greps
  # GET /greps.json
  def index
    @greps = Grep.all
  end

  # GET /greps/1
  # GET /greps/1.json
  def show
  end

  # GET /greps/new
  def new
    @grep = Grep.new
  end

  # GET /greps/1/edit
  def edit
  end

  # POST /greps
  # POST /greps.json
  def create
    @grep = Grep.new(grep_params)

    respond_to do |format|
      if @grep.save
        @grep_response = "Done"
        format.html { redirect_to @grep, notice: 'Grep was successfully created.' }
        format.json { render :show, status: :created, location: @grep }
      else
        format.html { render :new }
        format.json { render json: @grep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /greps/1
  # PATCH/PUT /greps/1.json
  def update
    respond_to do |format|
      if @grep.update(grep_params)
        format.html { redirect_to @grep, notice: 'Grep was successfully updated.' }
        format.json { render :show, status: :ok, location: @grep }
      else
        format.html { render :edit }
        format.json { render json: @grep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /greps/1
  # DELETE /greps/1.json
  def destroy
    @grep.destroy
    respond_to do |format|
      format.html { redirect_to greps_url, notice: 'Grep was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grep
      @grep = Grep.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grep_params
      params.require(:grep).permit(:greppable_type, :greppable_id, :rule_id, :results, :custom, :search_value)
    end
end
