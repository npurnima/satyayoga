class CoursesController < ApplicationController
 # layout 'index'
  before_filter :saadhakacheck, :except => [:index]
  before_filter :authorize_user
  def index
    @courses = Course.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }

    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course}
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    @course.owner = session[:user_id]
    if (params[:course][:filepath])
      tem_filePath = upload_file(@course.filePath, "app/assets/courses")
      @course.filePath = "app/assets/courses/"+tem_filePath
    end
    respond_to do |format|

      if @course.save
        format.html { redirect_to courses_path, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    if (params[:course][:filepath])
      tem_filePath = upload_file(@course.filePath, "app/assets/courses")
      params[:course][:filepath] = tem_filePath
    end
    respond_to do |format|

      if @course.update_attributes(params[:course])
           format.html { redirect_to courses_path, notice: 'Course was successfully updated.' }
           format.json { head :no_content }
       else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

    # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_path }
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

  def read_file
     @course = Course.find_by_id(params[:id])

     respond_to do |format|
       if File.exist?(@course.filepath)
         format.html { send_file "#{@course.filepath}", :type => "application/text", :readonly => true }
       else
         flash[:error] = "File  does not exist!"
         format.html { redirect_to(:back) }
       end
     end
  end

  def user_courses
    @courses = Course.find_user_courses(params[:id])
  end

end
