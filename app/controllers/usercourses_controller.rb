class UsercoursesController < ApplicationController
  layout 'index'
  before_filter :authorize_user
  before_filter :guidecheck,:except =>[:change_status,:edit,:update_status,:update]
  # GET /usercourses
  # GET /usercourses.json
  def index
    @usercourses = Usercourse.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usercourses }
    end
  end

  # GET /usercourses/1
  # GET /usercourses/1.json
  def show
    @usercourse = Usercourse.find(params[:id])
    @user = User.find(@usercourse.user_id)
    @course = Course.find(@usercourse.course_id)
    @guide = User.find(@usercourse.guide_id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usercourse }
    end
  end

  # GET /usercourses/new
  # GET /usercourses/new.json
  def new
    @usercourse = Usercourse.new
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usercourse }
    end
  end

  # GET /usercourses/1/edit
  def edit
    @usercourse = Usercourse.find(params[:id])
  end

  # POST /usercourses
  # POST /usercourses.json
  def create
    params[:usercourse][:course_id]= params[:id]
    params[:usercourse][:guide_id] = session[:user_id]
    @usercourse = Usercourse.new(params[:usercourse])
    @usercourse.date = DateTime.now
    @usercourse.practice_type =  'Individual'
    @usercourse.status  = 'Assigned'
    respond_to do |format|
      if @usercourse.save
        format.html { redirect_to courses_by_saadhaka_path(@usercourse.user_id), notice: 'Usercourse was successfully created.' }
        format.json { render json: @usercourse, status: :created, location: @usercourse }
      else
        format.html { render action: "new" }
        format.json { render json: @usercourse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usercourses/1
  # PUT /usercourses/1.json
  def update
    @usercourse = Usercourse.find(params[:id])

    respond_to do |format|
      if @usercourse.update_attributes(params[:usercourse])
        format.html { redirect_to courses_by_saadhaka_path(@usercourse.user_id), notice: 'Usercourse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usercourse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usercourses/1
  # DELETE /usercourses/1.json
  def destroy
    @usercourse = Usercourse.find(params[:id])
    @usercourse.destroy

    respond_to do |format|
      format.html { redirect_to usercourses_url }
      format.json { head :no_content }
    end
  end

  def saadhakas_by_course
       @usercourses = Usercourse.find_all_by_course(params[:id])
        @course = Course.find(params[:id])
       respond_to do |format|
         format.html {}
         format.json { render json: @usercourses }
       end
  end

  def courses_by_saadhaka
      @usercourses = Usercourse.find_by_user(params[:id])
      @user = User.find(params[:id])
      respond_to do |format|
        format.html
        format.json { render json: @usercourses }
      end
  end

  def assign_a_course
    @usercourse = Usercourse.new
    @courses = Course.all
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @usercourses }
    end
  end
  def create_usercourse
    params[:usercourse][:guide_id] = session[:user_id]
    @usercourse = Usercourse.new(params[:usercourse])
    @usercourse.user_id = params[:id]

    respond_to do |format|
      if @usercourse.save
        format.html { redirect_to saadhakas_by_guide_path(session[:user_id]), notice: 'Course Was Successfully Assigned.' }
        format.json { render json: @usercourse, status: :created, location: @usercourse }
      else
        format.html { render action: "new" }
        format.json { render json: @usercourse.errors, status: :unprocessable_entity }
      end
    end
  end
  PRACTICED_USERS =[]
   def assign_a_practice
     adduser=[]
     @practice = Practice.find(params[:id])
     @guide = User.find(@practice.guide_id)
     @saadhakas = Userrole.find_all_saadhakas_by_guide(@practice.guide_id)

   end

   def add_attendence

     @practice = Practice.find(params[:id])
     params[:adduser]<< @practice.guide_id
     logger.debug ("After adding the guide_id : to the list:#{params[:adduser]}")
     (0..params[:adduser].count-1).each do |u|
       @usercourse = Usercourse.new
        @usercourse.user_id= params[:adduser][u]
        logger.debug ("The user id in #{ @usercourse.user_id}")
       @usercourse.course_id = @practice.course_id
        logger.debug ("The course id in #{ @usercourse.course_id}")
       @usercourse.guide_id  = @practice.guide_id
       @usercourse.course_no_from = @practice.course_from_number
       @usercourse.course_no_to = @practice.course_to_number
       @usercourse.date = @practice.date
       @usercourse.practice_type  = 'Group'
       @usercourse.save

     end
     respond_to do |format|
      # if @usercourse.save
         format.html{redirect_to saadhakas_by_course_path(@practice.course_id),  notice:'All the Attendents has been added successfully.'}
       #else
        # format.html{redirect_to guide_homepages_path($logged_user_id),  notice:'Sorry! the Attendents has not been added.'}
       #end

     end
   end

  def change_status
    @usercourse = Usercourse.find(params[:id])

  end

  def update_status
    @usercourse = Usercourse.find(params[:id])

    respond_to do |format|
      if @usercourse.update_attributes(params[:usercourse])
        format.html { redirect_to mypage_path(session[:user_id]), notice: 'Your Practice Status has been successfully updated.' }
        format.json { head :no_content }
      end
    end
  end
end
