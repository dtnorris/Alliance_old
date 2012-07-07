class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @user = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @members = Member.find_all_by_user_id(@user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end


  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @members = Member.find_all_by_user_id(@user.id)
    @member = Member.new
    session[:user_id_for_membership] = @user.id
  end

  # GET /users/1/edit_password_form
  def edit_password_form
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  # def new_for_chapter
  #   @user = User.new
  #   #@user.chapter_id = session[:chapter_id_for_new_user]

  #   respond_to do |format|
  #     format.html
  #     format.json {render json: @character}
  #   end
  # end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.dragon_stamps = 0
    @user.save
    @member = Member.new(user_id: @user.id, chapter_id: session[:chapter_id_for_new_user], goblin_stamps: 0)
    @member.save
    session.delete :chapter_id_for_new_user

    respond_to do |format|
      if @user.save
        format.html { redirect_to chapters_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    #debugger
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @characters = Character.find_all_by_user_id(@user.id)
    @members = Member.find_all_by_user_id(@user.id)
    #debugger
    @user.destroy
    @characters.each do |ch|
      #debugger
      ch.destroy
    end
    @members.each do |mb|
      mb.destroy
    end

    respond_to do |format|
      format.html { redirect_to alliance_player_members_path }
      format.json { head :no_content }
    end
  end
end