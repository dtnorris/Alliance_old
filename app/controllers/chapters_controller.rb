class ChaptersController < ApplicationController
  load_and_authorize_resource
  # GET /chapters
  # GET /chapters.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chapters }
    end
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @events = Event.find_all_by_chapter_id(@chapter.id)
    @members = Member.find_all_by_chapter_id(@chapter.id)
    @users = User.all_for_given_members(@members)
    @characters = Character.find_all_by_home_chapter(@chapter.id)
    session[:chapter_id_for_new_user] = params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/new
  # GET /chapters/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters
  # POST /chapters.json
  def create
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @chapter, notice: 'Chapter was successfully created.' }
        format.json { render json: @chapter, status: :created, location: @chapter }
      else
        format.html { render action: "new" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chapters/1
  # PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  # def destroy
  #   @chapter.destroy
    
  #   respond_to do |format|
  #     format.html { redirect_to chapters_url }
  #     format.json { head :no_content }
  #   end
  # end
end
