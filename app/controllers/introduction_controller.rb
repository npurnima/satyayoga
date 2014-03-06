class IntroductionController < ApplicationController
  #layout 'index'
  before_filter :authorize_user, :except => [:index,:read_file]
 # before_filter :admincheck [:new,:edit,:destroy,:user_files]


  def index
      @datafiles = Datafile.all
      respond_to do |format|
        format.html{   }
        format.json {render json: @datafiles}

      end
  end
  def show

  end
  def new
   @datafile = Datafile.new
   logger.debug "entered into the new"
    respond_to do |format|
      format.html {}
     #  format.json {render json: @datafile}

    end
  end
  def edit
    @datafile = Datafile.find(params[:id])
  end
  def create

    @datafile = Datafile.new(params[:datafile])
    @datafile.owner = session[:user_id]
    if (params[:datafile][:filepath])
      tem_filePath = upload_file(@datafile.filepath, "public/datafiles")
      @datafile.filepath = "app/assets/datafiles/"+tem_filePath
    end
    respond_to do |format|

      if @datafile.save
        format.html {redirect_to :index, notice: 'datafile has been created successfully!'}
        format.json {render json: :index, status: :created, location: @datafile }
      else
        format.html{render action: "new"}
        format.json {render json: @datafile.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    @datafile = Datafile.find(params[:id])

    if (params[:datafile][:filepath])
      tem_filePath = upload_file(params[:datafile][:filepath], "public/datafiles")
      params[:datafile][:filepath] = "app/assets/datafiles/"+tem_filePath
    end

    respond_to do |format|

      if @datafile.update_attributes(params[:datafile])

        format.html { redirect_to @datafile, notice: 'datafile was successfully updated.' }
        format.json { head :no_content }

      else
        format.html { render action: "edit" }
        format.json { render json: @datafile.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @datafile = Datafile.find(params[:id])
    @datafile.destroy

    respond_to do |format|
      format.html { redirect_to introduction_path }
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
    @datafile = Datafile.find(params[:id])

    respond_to do |format|
      if File.exist?(@datafile.filepath)

        format.html { send_file "#{@datafile.filepath}", :type => "application/text",
                                :readonly => true, :disposition => "inline" }

      else
        format.html { redirect_to :back, notice: "File  does not exist!" }
      end
    end
  end

  def user_files
    @datafiles  = Datafile.find_user_files(params[:id])
  end
end
