class PatronXpsController < ApplicationController
  # GET /patron_xps
  # GET /patron_xps.json
  def index
    @patron_xps = PatronXp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patron_xps }
    end
  end

  # GET /patron_xps/1
  # GET /patron_xps/1.json
  def show
    @patron_xp = PatronXp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patron_xp }
    end
  end

  # GET /patron_xps/new
  # GET /patron_xps/new.json
  def new
    @patron_xp = PatronXp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patron_xp }
    end
  end

  # GET /patron_xps/1/edit
  def edit
    @patron_xp = PatronXp.find(params[:id])
  end

  # POST /patron_xps
  # POST /patron_xps.json
  def create
    @patron_xp = PatronXp.new(params[:patron_xp])

    respond_to do |format|
      if @patron_xp.save
        format.html { redirect_to @patron_xp, notice: 'Patron xp was successfully created.' }
        format.json { render json: @patron_xp, status: :created, location: @patron_xp }
      else
        format.html { render action: "new" }
        format.json { render json: @patron_xp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patron_xps/1
  # PUT /patron_xps/1.json
  def update
    @patron_xp = PatronXp.find(params[:id])

    respond_to do |format|
      if @patron_xp.update_attributes(params[:patron_xp])
        format.html { redirect_to @patron_xp, notice: 'Patron xp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @patron_xp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patron_xps/1
  # DELETE /patron_xps/1.json
  def destroy
    @patron_xp = PatronXp.find(params[:id])
    @patron_xp.destroy

    respond_to do |format|
      format.html { redirect_to patron_xps_url }
      format.json { head :no_content }
    end
  end
end
