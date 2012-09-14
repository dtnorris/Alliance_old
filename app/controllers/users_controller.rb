require 'will_paginate/array'

class UsersController < ApplicationController
  load_and_authorize_resource :except => [:show, :create]

  #GET /users
  #GET /users.json
  def index
    authorize! :index, Ability
    @search = User.search(params[:q])
    @users = @search.result
    if params[:chapter_id]
      @chapter = Chapter.find(params[:chapter_id])
    elsif params[:q] and params[:q][:chapter_id]
      @chapter = Chapter.find(params[:q][:chapter_id])
    end
    if @chapter
      @members = @chapter.members
      @users = @users.inject([]) { |arr,u| arr << u if u.member_of_chapter(@chapter); arr }
    end
    @users = @users.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id]) if params[:id]
    @user = User.find(current_user.id) unless @user
    session[:user_id_for_membership] = @user.id
    @members = Member.find_all_by_user_id(@user.id)
    authorize! :show, @user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @members = Member.find_all_by_user_id(@user.id)
    @member = Member.new
    session[:user_id_for_membership] = @user.id
  end

  # GET /users/new
  # GET /users/new.json
  def new
    if params[:chapter_id]
      @chapter = Chapter.find(params[:chapter_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @chapter = Chapter.find(params[:user][:chapter_id])
    params[:user].delete('chapter_id')
    @assignment = Assignment.new(role_id: params[:user][:role_id])
    params[:user].delete('role_id')

    @user = User.create(params[:user])
    @user.dragon_stamps = 0
    @user.save
    @assignment.user_id = @user.id
    @assignment.save
    @member = Member.create(user_id: @user.id, chapter_id: @chapter.id, goblin_stamps: 0)
    authorize! :create, @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to chapter_users_path(@member.chapter_id), notice: 'Player was successfully created' }
        format.json { render json: @user, status: :created, location: @user }
      else
        flash[:error] = 'Failed to create new player'
        format.html { redirect_to new_chapter_user_path(@member.chapter_id) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users/1
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        flash[:error] = 'Error updating user.'
        format.html { redirect_to edit_user_path(@user) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_password
    @user = User.find(params[:user_id])
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to edit_user_path(@user), notice: 'Password successfully updated.'
    else
      flash[:error] = 'Error updating password.'
      redirect_to user_edit_password_form_path(@user)
    end
  end

  def edit_password_form
    @user = User.find(params[:user_id])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # def destroy
  #   @characters = Character.find_all_by_user_id(@user.id)
  #   @members = Member.find_all_by_user_id(@user.id)
  #   @user.destroy
  #   @characters.each do |ch|
  #     ch.destroy
  #   end
  #   @members.each do |mb|
  #     mb.destroy
  #   end

  #   respond_to do |format|
  #     format.html { redirect_to alliance_player_members_path }
  #     format.json { head :no_content }
  #   end
  # end

  # PUT /users/1
  # PUT /users/1.json
  
end