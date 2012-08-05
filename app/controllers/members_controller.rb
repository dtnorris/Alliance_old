class MembersController < ApplicationController
  load_and_authorize_resource :except => [:alliance_player, :create]

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])
    @member.goblin_stamps = 0
    @member.blanket_list = false
    another_like_me = Member.find_by_user_id_and_chapter_id(@member.user_id, @member.chapter_id)
    authorize! :create, @member

    respond_to do |format|
      if !another_like_me
        if @member.save 
          format.html { redirect_to edit_user_path(@member.user_id), notice: 'Member was successfully created.' }
          format.json { render json: @member, status: :created, location: @member }
        end
      else
        format.html { redirect_to edit_user_path(current_user.id) }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # # GET /members/1/edit
  def edit  
    @user = User.find(params[:user_id]) if params[:user_id]
  end

  # PUT /members/1
  # PUT /members/1.json
  def update

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to blanket_list_chapter_path(@member.chapter_id), notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /members
  # GET /members.json
  # def index
  #   @members = Member.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @members }
  #   end
  # end

  # GET /members/1
  # GET /members/1.json
  # def show
  #   @member = Member.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @member }
  #   end
  # end

  # GET /members/new
  # GET /members/new.json
  # def new
  #   @member = Member.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @member }
  #   end
  # end

  # # DELETE /members/1
  # # DELETE /members/1.json
  # def destroy
  #   @member = Member.find(params[:id])
  #   @member.destroy

  #   respond_to do |format|
  #     format.html { redirect_to members_url }
  #     format.json { head :no_content }
  #   end
  # end
end
