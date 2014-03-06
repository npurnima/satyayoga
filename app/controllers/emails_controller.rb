class EmailsController < ApplicationController

  #  layout 'index'
    before_filter :authorize_user

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emails }
    end
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
    @email = Email.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email }
    end
  end

  # GET /emails/new
  # GET /emails/new.json
  def new
    @email = Email.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @email }
    end
  end

  # GET /emails/1/edit
  def edit
    @email = Email.find(params[:id])
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(params[:email])
    @user = User.find(session[:user_id])
    if   session[:privilage]== 4
      @guide =User.find_by_username('nmjanapati')
    else
      @guide =  User.find(Userrole.find_by_user_id(@user.id).guide_id )
    end
    @email.email_from = @user.username

    @email.email_to  =  @guide.username
    respond_to do |format|
      if @email.save

        format.html { redirect_to mypage_path(session[:user_id]), notice: 'Your Email Has Been Sent Successfully.' }
        format.json { render json: @email, status: :created, location: @email }
      #  ReplyMailer.send_mail(@email).deliver
      else
        format.html { render action: "new" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emails/1
  # PUT /emails/1.json
  def update
    @email = Email.find(params[:id])

    respond_to do |format|
      if @email.update_attributes(params[:email])
        format.html { redirect_to @email, notice: 'Email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email = Email.find(params[:id])
    @email.destroy

    respond_to do |format|
      format.html { redirect_to emails_url }
      format.json { head :no_content }
    end
  end

  def contact_guide
     @email = Email.new(params[:contact_guide])
     @user = User.find(session[:user_id])
     if   session[:privilage]== 4
        @guide =User.find_by_username('nmjanapati')
      else
        @guide =  User.find(Userrole.find_by_user_id(@user.id).guide_id )
     end
    @email.email_from = @user.username

    @email.email_to  =  @guide.username
     respond_to do |format|
       if @email.save
         format.html { redirect_to mypage_path(session[:user_id]), notice: 'Your Request Has Been Sent Successfully.' }
         format.json { render json: @email }
       else
         format.html { render action: "contact_guide" }
         format.json { render json: @email.errors, status: :unprocessable_entity }
       end
     end
  end
end
