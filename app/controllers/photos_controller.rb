class PhotosController < ApplicationController
  # layout 'index'
   before_filter :authorize_user, :except => [:album_photos,:slideshow,:photos_show]
   before_filter :saadhakacheck, :except => [:album_photos,:slideshow,:photos_show]
   def index
    @photos = Photo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new
    @photo.album_id = params[:id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  def multiple_photos

   @photo1,@photo2,@photo3,@photo4,@photo5,@photo6 = Photo.new

  end
  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])
    tem_title = upload_file(@photo.title,"app/assets/images/album_images")
    @photo.title = "album_images/"+tem_title
    @photo.owner =  session[:user_id]
    respond_to do |format|
      if @photo.save
        format.html { redirect_to all_album_photos_path(@photo.album_id), notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_multiple

       if params[:photo1][:title]
         @photo1 = Photo.new(params[:photo1])
          tem_title = upload_file(@photo1.title,"app/assets/images/album_images")
          @photo1.title = "album_images/"+tem_title
          @photo1.album_id = params[:id]
          @photo1.save

          if params[:photo2][:title]
          @photo2 = Photo.new(params[:photo2])
            tem_title = upload_file(@photo2.title,"app/assets/images/album_images")
            @photo2.title = "album_images/"+tem_title
            @photo2.album_id = params[:id]
            @photo2.save

            if params[:photo3][:title]
              @photo3 = Photo.new(params[:photo3])
              tem_title = upload_file(@photo3.title,"app/assets/images/album_images")
              @photo3.title = "album_images/"+tem_title
              @photo3.album_id = params[:id]
              @photo3.save

              if params[:photo4][:title]
                @photo4= Photo.new(params[:photo4])
                tem_title = upload_file(@photo4.title,"app/assets/images/album_images")
                @photo4.title = "album_images/"+tem_title
                @photo4.album_id = params[:id]
                @photo4.save

                if params[:photo5][:title]
                  @photo5 = Photo.new(params[:photo5])
                  tem_title = upload_file(@photo5.title,"app/assets/images/album_images")
                  @photo5.album_id = params[:id]
                  @photo5.save

                  if params[:photo6][:title]
                    @photo6 = Photo.new(params[:photo6])
                    tem_title = upload_file(@photo6.title,"app/assets/images/album_images")
                    @photo6.title = "album_images/"+tem_title
                    @photo6.album_id = params[:id]
                    if @photo6.save
                        redirect_to all_album_photos_path(params[:id]), notice: ' The Photos has been successfully added to the Album.'
                    end

                  else
                     redirect_to all_album_photos_path(params[:id]), notice: 'The Photos has been successfully added to the Album.'
                  end
                else
                   redirect_to all_album_photos_path(params[:id]), notice: 'The Photos has been successfully added to the Album.'
                end
              else
                 redirect_to all_album_photos_path(params[:id]), notice: 'The Photos has been successfully added to the Album.'
              end
             else
                redirect_to all_album_photos_path(params[:id]), notice: 'The Photos has been successfully added to the Album.'
             end
          else
             redirect_to all_album_photos_path(params[:id]), notice: 'The Photos has been successfully added to the Album.'
          end
       else
           redirect_to album_new_multiple_photos_path(params[:id]), notice: 'Please Browse the Photos and upload to the Album. '
       end



  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])
    if (params[:photo][:title])
      tem_title = upload_file(params[:photo][:title],"app/assets/images/album_images")
      params[:photo][:title] = "album_images/"+tem_title
    end
    respond_to do |format|

      if @photo.update_attributes(params[:photo])
        format.html { redirect_to all_album_photos_path(@photo.album_id), notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  def album_photos
    @photos = Photo.find_all_by_album_id(params[:id])
    @album = Album.find(params[:id])
  end

  def photos_show
    @photos = Photo.find_all_by_album_id(params[:id])
    @photocount = Photo.find_all_by_album_id(params[:id]).count()
    respond_to do |format|
      format.html # photos_show.html.erb
      format.json { render json: @photos }
    end

  end
   def slideshow
     @photos = Photo.find_all_by_album_id(params[:id])
     @photocount = Photo.find_all_by_album_id(params[:id]).count()
     respond_to do |format|
       format.html # photos_show.html.erb
       format.json { render json: @photos }
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
end
