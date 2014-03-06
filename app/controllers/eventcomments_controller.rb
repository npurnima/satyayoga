class EventcommentsController < ApplicationController
 # layout 'index'
 # before_filter :authorize_user,'new'

  def new
  #  if !session[:user_id]
  #    redirect_to user_signin_path(0), notice: 'Sorry! Please Signin before you Add a Comment.'
  #  else
      @eventcomment = Eventcomment.new
      @event = Event.find(params[:id])
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @eventcomment }
      end
  #  end
  end

  # GET /eventcomments/1/edit
  def edit
    @eventcomment = Eventcomment.find(params[:id])
  end

  # POST /eventcomments
  # POST /eventcomments.json
  def create
    if !session[:user_id]
       redirect_to user_signin_path(0), notice: 'Sorry! Please Signin before you Add a Comment.'
    else
    params[:eventcomment][:event_id]= params[:id]
    params[:eventcomment][:user_id] = session[:user_id]
    @eventcomment = Eventcomment.new(params[:eventcomment])

    respond_to do |format|
      if !session[:user_id]
          format.html { redirect_to user_signin_path(0), notice: 'Sorry! Please Signin before you Add a Comment.' }
      else
        if @eventcomment.save
          format.html { redirect_to event_path(params[:id]), notice: 'Your Comment was successfully Added.' }
          format.js
          #format.json { render json: @eventcomment, status: :created, location: @eventcomment }
        else
          format.html { render action: "new" }
          format.json { render json: @eventcomment.errors, status: :unprocessable_entity }
        end
      end
    end
    end
  end

  # PUT /eventcomments/1
  # PUT /eventcomments/1.json
  def update
    @eventcomment = Eventcomment.find(params[:id])

    respond_to do |format|
      if @eventcomment.update_attributes(params[:eventcomment])
        format.html { redirect_to event_path(params[:id]), notice: 'Eventcomment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @eventcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventcomments/1
  # DELETE /eventcomments/1.json
  def destroy
    @eventcomment = Eventcomment.find(params[:id])
    @eventcomment.destroy

    respond_to do |format|
      format.html { redirect_to eventcomments_url }
      format.json { head :no_content }
    end
  end

  def event_comments
      @eventcomments = Eventcomment.find_comments_by_event(params[:id])
       @event = Event.find(params[:id])
  end

  def  user_event_comments
    @user_eventcomments = Eventcomment.find_comments_by_user(session[:user_id])

  end

  def user_eventcomments
    @eventcomments = Eventcomment.find_comments_by_user(session[:user_id])
  end

end
