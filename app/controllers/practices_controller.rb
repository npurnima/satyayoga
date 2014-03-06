class PracticesController < ApplicationController
  #layout 'index'
  before_filter :guidecheck
  def index
    @practices = Practice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @practices }
    end
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
    @practice = Practice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @practice }
    end
  end

  # GET /practices/new
  # GET /practices/new.json
  def new
    @practice = Practice.new
    @courses = Course.all


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @practice }
    end
  end

  # GET /practices/1/edit
  def edit
    @practice = Practice.find(params[:id])
    @courses = Course.all

  end

  # POST /practices
  # POST /practices.json
  def create
    @practice = Practice.new(params[:practice])
    @practice.owner = session[:user_id]
    respond_to do |format|
      if @practice.save
        format.html { redirect_to @practice, notice: 'Practice was successfully created.' }
        format.json { render json: @practice, status: :created, location: @practice }
      else
        format.html { render action: "new" }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /practices/1
  # PUT /practices/1.json
  def update
    @practice = Practice.find(params[:id])

    respond_to do |format|
      if @practice.update_attributes(params[:practice])
        format.html { redirect_to @practice, notice: 'Practice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @practice = Practice.find(params[:id])
    @practice.destroy

    respond_to do |format|
      format.html { redirect_to practices_url }
      format.json { head :no_content }
    end
  end

  def user_practices
    @practices = Practice.find_user_practices(params[:id])
  end
end
