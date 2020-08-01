class LanguagesController < ApplicationController
  before_action :set_language, only: [:show, :edit, :update, :destroy]

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all.order(:name)
  end

  def build_languages
    @languages = Language.pluck(:name)
    langs_for_building = Language.get_all_languages
    if langs_for_building.count == 0
      redirect_to languages_path, notice: "No languages were returned. Check language retrieval."
    end
    count = 0
    new_count = 0
    langs_for_building.each do |l|
      p l[:name]
      p l[:url]
      @new_lang = Language.new(:name => l[:name], :url => l[:url])
      if @languages.present?
        unless @languages.include? @new_lang.name
          if @new_lang.save
            new_count += 1
          end
        end
      else
        if @new_lang.save
          new_count += 1
        end
      end
      count += 1
    end
    if count == langs_for_building.count
      redirect_to languages_path, notice: "#{new_count} new languages saved. #{Language.all.count} languages total in the database."
    else
      render :index
    end
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
    if Delayed::Job.any?
      @lang_update_status = :running
    else
      @lang_update_status ||= :default
    end
  end

  # GET /languages/new
  def new
    @language = Language.new
  end

  # GET /languages/1/edit
  def edit
  end

  # POST /languages
  # POST /languages.json
  def create
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to @language, notice: 'Language was successfully created.' }
        format.json { render :show, status: :created, location: @language }
      else
        format.html { render :new }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /languages/1
  # PATCH/PUT /languages/1.json
  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to @language, notice: 'Language was successfully updated.' }
        format.json { render :show, status: :ok, location: @language }
      else
        format.html { render :edit }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.json
  def destroy
    @language.destroy
    respond_to do |format|
      format.html { redirect_to languages_url, notice: 'Language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def create_new_language(languages)

  end

  # Use callbacks to share common setup or constraints between actions.
  def set_language
    @language = Language.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def language_params
    params.require(:language).permit(:repository_id, :name)
  end
end
