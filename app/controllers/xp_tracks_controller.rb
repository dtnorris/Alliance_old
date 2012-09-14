class XpTracksController < ApplicationController
  load_and_authorize_resource #:except => [:create]


  #GET /xp_tracks
  def index
    @character = Character.find(params[:character_id])
    @user = User.find(params[:user_id]) if params[:user_id]
    @chapter = Chapter.find(params[:chapter_id]) if params[:chapter_id]
    @xp_tracks = XpTrack.find_all_by_character_id(@character.id)
    authorize! :read, @character

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

end