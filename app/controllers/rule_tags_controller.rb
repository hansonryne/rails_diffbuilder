class RuleTagsController < ApplicationController
  before_action :set_rule_tag, only: [:show, :edit, :update, :destroy]

  # GET /rule_tags
  # GET /rule_tags.json
  def index
    @rule_tags = RuleTag.all
  end

  # GET /rule_tags/1
  # GET /rule_tags/1.json
  def show
  end

  # GET /rule_tags/new
  def new
    @rule_tag = RuleTag.new
  end

  # GET /rule_tags/1/edit
  def edit
  end

  # POST /rule_tags
  # POST /rule_tags.json
  def create
    @rule_tag = RuleTag.new(rule_tag_params)

    respond_to do |format|
      if @rule_tag.save
        format.html { redirect_to @rule_tag, notice: 'Rule tag was successfully created.' }
        format.json { render :show, status: :created, location: @rule_tag }
      else
        format.html { render :new }
        format.json { render json: @rule_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rule_tags/1
  # PATCH/PUT /rule_tags/1.json
  def update
    respond_to do |format|
      if @rule_tag.update(rule_tag_params)
        format.html { redirect_to @rule_tag, notice: 'Rule tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @rule_tag }
      else
        format.html { render :edit }
        format.json { render json: @rule_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rule_tags/1
  # DELETE /rule_tags/1.json
  def destroy
    @rule_tag.destroy
    respond_to do |format|
      format.html { redirect_to rule_tags_url, notice: 'Rule tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule_tag
      @rule_tag = RuleTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rule_tag_params
      params.require(:rule_tag).permit(:name, :rule_id)
    end
end
