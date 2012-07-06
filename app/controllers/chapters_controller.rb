class ChaptersController < ApplicationController
  # GET /chapters
  # GET /chapters.json
  def index
    @characters = Character.all
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
    end
  end
end