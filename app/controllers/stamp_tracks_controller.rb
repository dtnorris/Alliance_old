class StampTracksController < ApplicationController

  # POST /users/1/modify_stamps
  def create
    @user = User.find(session[:user_id_for_new_stamps])
    @chapter_id = session[:chapter_id_for_new_user]
    @membership = Member.find_by_user_id_and_chapter_id(@user.id, @chapter_id)

    @stamp_track = StampTrack.new
    @stamp_track.user_id = @user.id
    @stamp_track.chapter_id = @chapter_id.to_i
    @stamp_track.start_stamps = @membership.goblin_stamps
    @stamp_track.end_stamps = @stamp_track.start_stamps + params[:stamp_track][:amount_to_change].to_i
    @stamp_track.reason = params[:stamp_track][:reason]
    @stamp_track.save
    @membership.goblin_stamps += params[:stamp_track][:amount_to_change].to_i
    @membership.save
    authorize! :create, @stamp_track

    respond_to do |format|
      format.html { redirect_to view_goblins_user_path(@user.id) }
      format.json { render json: @user }
    end
  end

end