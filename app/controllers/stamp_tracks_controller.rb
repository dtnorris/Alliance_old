class StampTracksController < ApplicationController

  # POST /users/1/modify_stamps
  def create
    goblins = params[:stamp_track][:amount_to_change].to_i

    @stamp_track = StampTrack.new()
    @stamp_track.user_id = params[:stamp_track][:user_id]
    @stamp_track.chapter_id = params[:stamp_track][:chapter_id]
    @stamp_track.reason = params[:stamp_track][:reason]

    @user = User.find(@stamp_track.user_id)
    @chapter = Chapter.find(@stamp_track.chapter_id)
    @membership = Member.find_by_user_id_and_chapter_id(@user.id, @chapter.id)
    
    @stamp_track.start_stamps = @membership.goblin_stamps
    @stamp_track.end_stamps = @stamp_track.start_stamps + goblins
    @stamp_track.save
    @membership.goblin_stamps += params[:stamp_track][:amount_to_change].to_i
    @membership.save
    authorize! :create, @stamp_track

    if goblins > 0
      notice = "Added #{goblins} goblin stamps to #{@user.name}"
    elsif goblins < 0
      possitive = goblins - goblins - goblins
      notice = "Removed #{possitive} goblin stamps from #{@user.name}"
    else
      notice = 'Something strange happened'
    end

    respond_to do |format|
      format.html { redirect_to view_goblins_chapter_user_path(@chapter.id,@user.id), notice: notice }
      format.json { render json: @user }
    end
  end

end