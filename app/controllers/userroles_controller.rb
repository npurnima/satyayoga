class UserrolesController < ApplicationController
layout 'index'
before_filter :authorize_user
before_filter :guidecheck
  # GET /userroles
  # GET /userroles.json
  def index
    @userroles = Userrole.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @userroles }
    end
  end

  # GET /userroles/1
  # GET /userroles/1.json
  def show
    @userrole = Userrole.find_by_user_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @userrole }
    end
  end

  # GET /userroles/new
  # GET /userroles/new.json
  def new
   # logger.debug "The value of logged user id is: #{session[:user_id]} "
   # if session[:user_id].present?
      @userrole = Userrole.new
      @roles = Role.all
      @user = User.find(params[:id])

      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @userrole }
      end
   # else
    #  redirect_to user_signin_path, :notice=> " Before You Assign a New Role You Need To Signin. "
    #end
  end

  # GET /userroles/1/edit
  def edit
    @userrole = Userrole.find_by_user_id(params[:id])
    params[:old_role_id] = @userrole.role_id
    logger.debug("The old role_id when it is in edit #{params[:old_role_id]}")
    @roles = Role.all
    @user = User.find(params[:id])
    logger.debug"entered into edit userrole: #{params[:user_id]} and the role is: #{@userrole.role_id} "
  end


  def create

    params[:userrole][:user_id] = params[:id]
    params[:userrole][:assigned_by] = session[:username]

    @userrole = Userrole.new(params[:userrole])

    num_role = @userrole.role_id

    if ((num_role.to_i >= 1 && session[:privilage] == 1) or (num_role.to_i >= 2 && session[:privilage] <=2))
      respond_to do |format|
        @userrole.save
          format.html { redirect_to users_path, notice: 'Role was successfully added to the user.' }
          format.json { render json: @userrole, status: :created, location: @userrole }
      end
    else
      respond_to do |format|
        format.html { redirect_to users_path, notice:'Sorry! You are not authorised to assign this role.' }
        format.json { render json: @userrole.errors, status: :unprocessable_entity }
      end

    end
  end

  # PUT /userroles/1
  # PUT /userroles/1.json
  def update
    params[:userrole][:user_id] = params[:id]
    params[:userrole][:assigned_by] = session[:username]
    logger.debug("The old role_id when it is in update #{params[:old_role_id]} and #{params[:userrole][:role_id]}")
    if(params[:userrole][:role_id].to_i == 5 && params[:old_role_id].to_i<=3)
      logger.debug("The old role_id when it is in update in if #{params[:old_role_id]}")
      params[:userrole][:group_leader]='Yes'
      params[:userrole][:role_id]= params[:old_role_id]
    end

    @userrole = Userrole.find_by_user_id(params[:id])
    logger.debug("The update userrole are : #{@userrole.group_leader},and role id is#{@userrole.role_id}")
    respond_to do |format|
      if @userrole.update_attributes(params[:userrole])
        format.html { redirect_to users_path, notice: 'Userrole was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @userrole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userroles/1
  # DELETE /userroles/1.json
  def destroy
    @userrole = Userrole.find(params[:id])
    @userrole.destroy

    respond_to do |format|
      format.html { redirect_to userroles_url }
      format.json { head :no_content }
    end
  end

  def saadhakas_by_guide
    @saadhakas = Userrole.find_all_saadhakas_by_guide(params[:id])
    @guide = User.find(params[:id])

    respond_to do |format|
      format.html{}
    end
  end
end
