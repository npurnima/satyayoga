class UsersController < ApplicationController


 before_filter :guidecheck, :except => [:signin, :new,:signout,:edit,:show,:update,:create,:forgot_password,:change_password,:email_subscribe,:email_unsubscribe ]
 before_filter :authorize_user, :except => [:signin,:new,:create,:forgot_password,:change_password]


  def index

    @users = User.paginate(:page => params[:page], :per_page => 10)
   # @users = User.all

  end


  def show
    @user = User.find(params[:id])

  end

  def new
    @user = User.new

  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(params[:user])
    if params[:user][:password] != params[:user][:confirm_password]
      logger.debug" The value of in else wrong pass word id #{params[:user][:password]}"
       render :action => 'new', :notice =>"Please re confirm the password"
    else

    if (params[:user][:photo])
      tem_title = upload_file(@user.photo,"app/assets/images/user_profile_images")
      @user.photo = "user_profile_images/"+tem_title
    else
      @user.photo = "user_profile_images/default_user_photo.jpeg"
    end
    @user.email_subscriber = 'true'

      respond_to do |format|
        if @user.save
          UserMailer.welcome_email(@user).deliver
          format.html { redirect_to homepages_path, notice: 'User was successfully created.' }
        else
          format.html { render action: "new" }

        end

      end
    end

  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if (params[:user][:photo])
      tem_title = upload_file(params[:user][:photo],"app/assets/images/user_profile_images")
       params[:user][:photo] = "user_profile_images/"+tem_title

    end
    respond_to do |format|

      if @user.update_attributes(params[:user])

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


  def upload_file(uploaded_file, directory)
    filename = uploaded_file.original_filename
    tem_filePath = File.join(directory, filename)
    if File.exist?(tem_filePath)
      flash[:error] = "File already exists...Do you want to replace it?"
    else
      File.open(tem_filePath, "wb") { |f| f.write(uploaded_file.read) }
    end
    return   filename
  end
 def signin
   logger.debug("value of username: #{params[:username]}")
   if request.post?
     logger.debug("value of username: #{params[:username]}")
     logged_user = User.authenticate(params[:username], params[:password])
     if logged_user
       session[:user_id] = logged_user.id
       session[:username] = logged_user.firstname
       session[:privilage] = User.find_user_privilage(session[:user_id])
       respond_to do |format|
         format.html { redirect_to  homepages_path, :notice => "#{logged_user.firstname} you have successfully logged in" }

       end
     else
       respond_to do |format|
         format.html { redirect_to  :back || user_signin_path(0), :notice => "Invalid username/password combination.." }

       end
     end

   end
 end


  def signout
    #flash[:notice]="#{$logged_user_name} has logged out.."
    session[:user_id]= nil
    session[:username]= nil
    session[:privilage]= nil
    p = $privilage
    $logged_user_name = nil
    $privilage = nil
    $logged_user_id = nil
    $last_login_date = nil
    respond_to do |format|
       format.html {redirect_to homepages_path, :notice => "You are successfully signed out.."}
    end

  end

  def list_of_all_roles

    @userroles = Userrole.find_all_roles(params[:role_id])
    @role = @userroles.role

  end

  def forgot_password

       if request.post? &&  (params[:username] || params[:email])
          if params[:username]
              @user = User.find_by_username(params[:username])
          elsif  params[:email]
              @user = User.find_by_email(params[:email])
          else
             respond_to do |format|
               format.html{redirect_to user_signin_path(0), :notice => "Sorry the given information is not valid "   }
             end
          end
       end
       if @user
         UserMailer.forgot_password_email(@user).deliver
         respond_to do |format|
           format.html{redirect_to homepages_path, :notice => "Check your email to change your password and access the application"}
         end

       end

  end

  def change_password

    if (request.post?) && (params[:password] == params[:confirm_password])

         respond_to do |format|

           if User.change_password(params[:username],params[:password])

             format.html { redirect_to user_signin_path(0), :notice=> "You have successfully changed your Password! You can now login with your new password" }

           else
             format.html { redirect_to user_change_password_path(0), :notice=> "Some thing went wrong: Please try to change your Password again" }

           end
         end

    end
  end

  def email_subscribe

      change_status = User.change_email_subscription_status(session[:user_id],true)
      respond_to do  |format|
         if change_status
            format.html {redirect_to mypage_path(session[:user_id]), :notice=> "You have been successfully added to email subscriber list" }

         end
      end
  end

  def email_unsubscribe

    change_status = User.change_email_subscription_status(session[:user_id],false)

    respond_to do  |format|
      if change_status == true
        format.html {redirect_to mypage_path(session[:user_id]), :notice=> "You have been successfully removed from email subscriber list" }
      end

    end
  end

end
