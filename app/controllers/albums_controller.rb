class AlbumsController < ApplicationController
 # layout 'index'
  before_filter :authorize_user, :except=>[:index]
  before_filter :saadhakacheck, :except => [:index]
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new

    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(params[:album])
    if (params[:album][:coverpage])
      tem_coverPage = upload_file(@album.coverpage,"app/assets/images/album_images")
      @album.coverpage = "album_images/"+tem_coverPage
    else
      @album.coverpage = "album_images/album_default.jpg"
    end
    @album.owner = session[:user_id]
    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    @album = Album.find(params[:id])
    if params[:album][:coverpage]
      tem_coverPage = upload_file(params[:album][:coverpage],"app/assets/images/album_images")
      params[:album][:coverpage] = "album_images/"+tem_coverPage
    end

    respond_to do |format|

      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to user_albums_path(session[:user_id]),:notice => "Your Album has been successfully Deleted" }
      format.json { head :no_content }
    end
  end

  def upload_file(uploaded_file, directory)
    filename = uploaded_file.original_filename
    #  directory = "app/assets/images/album_images"
    tem_filePath = File.join(directory, filename)
    if File.exist?(tem_filePath)
      flash[:error] = "File already exists...Do you want to replace it?"
    else
      File.open(tem_filePath, "wb") { |f| f.write(uploaded_file.read) }
    end
    return   filename
  end

  def user_albums
    @albums = Album.find_all_user_albums(params[:id])
  end
end
