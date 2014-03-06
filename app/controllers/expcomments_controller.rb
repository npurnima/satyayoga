class ExpcommentsController < ApplicationController
 # layout 'index'
  before_filter :authorize_user, :except=>[:index]
  def index
    @expcomments = Expcomment.find_all_by_exp_id(params[:id])
    @private_comments =  Expcomment.find_all_private_comments(session[:user_id],params[:id])
    @experience = Experience.find(params[:id])
    @expcomment = Expcomment.new
    @experiences = Experience.all
    @user = User.find(@experience.owner)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expcomments }
    end
  end

  # GET /expcomments/1
  # GET /expcomments/1.json
  def show
    @expcomment = Expcomment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expcomment }
    end
  end

  # GET /expcomments/new
  # GET /expcomments/new.json
  def new
    @expcomment = Expcomment.new(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expcomment }
    end
  end

  # GET /expcomments/1/edit
  def edit
    @expcomment = Expcomment.find(params[:id])
  end

  # POST /expcomments
  # POST /expcomments.json
  def create


    if session[:user_id]
      @expcomment = Expcomment.new(params[:expcomment])
      @expcomment.exp_id = params[:id]
      @expcomment.owner  = session[:user_id]
      if !(params[:expcomment][:comment_type])
        @expcomment.comment_type = 'Public'
      end
    else
       respond_to do |format|
         format.html{redirect_to user_signin_path(0),notice:'Sorry! please signin to add your comment'}
       end
    end
    respond_to do |format|
      if @expcomment.save
         puts "The experience id is : #{@expcomment.exp_id}"

         UserMailer.new_comment_notification(@expcomment).deliver

        format.html { redirect_to expcomments_path(params[:id]), notice: 'Your comment on the experience was successfully added.' }
        format.json { render json: @expcomment, status: :created, location: @expcomment }
      else
        format.html { redirect_to user_signin_path(0),notice:'Sorry! please signin to add your comment' }
        format.json { render json: @expcomment.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /expcomments/1
  # PUT /expcomments/1.json
  def update
    @expcomment = Expcomment.find(params[:id])

    respond_to do |format|
      if @expcomment.update_attributes(params[:expcomment])
        format.html { redirect_to @expcomment, notice: 'Expcomment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expcomment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expcomments/1
  # DELETE /expcomments/1.json
  def destroy
    @expcomment = Expcomment.find(params[:id])
    @expcomment.destroy

    respond_to do |format|
      format.html { redirect_to expcomments_url }
      format.json { head :no_content }
    end
  end

  def exp_user_comments
    @usercomments = Expcomment.find_all_user_comments(session[:user_id])
  end
end
