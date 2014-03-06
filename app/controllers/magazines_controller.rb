class MagazinesController < ApplicationController
   #layout 'index'
   before_filter :authorize_user, :except =>[:index,:latest_english,:latest_telugu,
                                             :telugu_archives,:english_archives,
                                             :latest_telugu_english,:read_file]

   before_filter :guidecheck, :except =>[:index,:latest_english,:telugu_archives,
                                         :latest_telugu,:english_archives,
                                         :latest_telugu_english,:read_file]

   def index

     @magazines = Magazine.all
     @years = Magazine.find_all_magazine_years('Telugu')
     @telugu_latest = @magazines.sort(year).order(month).limit(2)
    # @Eyears = Magazine.find_all_magazine_years('English')
    # @Tyears = Magazine.find_all_magazine_years('Telugu')

  end


  def new

     @magazine = Magazine.new

  end


  def show

     @magazine = Magazine.find(params[:id])
     @Eyears = Magazine.find_all_magazine_years('English')
     @Tyears = Magazine.find_all_magazine_years('Telugu')

  end


  def edit

      @magazine = Magazine.find(params[:id])
  end

  def create

    @magazine = Magazine.new(params[:magazine])
    @magazine.owner = session[:user_id]
    if (params[:magazine][:filepath])
      tem_filePath = upload_file(@magazine.filepath, "app/assets/magazines")
      @magazine.filepath = "app/assets/magazines/"+tem_filePath
      if(params[:magazine][:coverpageimage])
        tem_coverPage = upload_file(@magazine.coverpageimage,"app/assets/images/magazine_cover_pages")
        @magazine.coverpageimage = "magazine_cover_pages/"+tem_coverPage
      else
        @magazine.coverpageimage = "magazine_cover_pages/articles-default.gif"
      end
    end
    respond_to do |format|

      if @magazine.save
        @users =  User.find_all_email_subscribers()
        @users.each do |user|

          UserMailer.new_magazine_notification(@magazine,user).deliver
        end
          format.html {redirect_to user_magazines_path(session[:user_id]), notice: 'Magazine has been created successfully!'}
          format.json {render json: @magazine, status: :created, location: @magazine }
      else
          format.html{render action: "new"}
          format.json {render json: @magazine.errors, status: :unprocessable_entity }
      end
    end
  end

  def latest_two_telugu_magazines
    # @latest_magazines = Magazine.find_latest_two
     @telugu_latest = Magazine.find_latest_telugu
     @english_latest = Magazine.find_latest_english
     logger.debug("The latest two telugu magazines from  controller: #{@latest_magazines.all}")

  end

   def telugu_archives
     @magazines = Magazine.find_telugu_archives(params[:id])
     @Eyears = Magazine.find_all_magazine_years('English')
     @Tyears = Magazine.find_all_magazine_years('Telugu')

     respond_to do |format|

         format.html { }
         format.json { render json: @magazines}
     end
   end
   def latest_english
     @magazines = Magazine.find_latest_english
     @years = Magazine.find_all_magazine_years('English')
     logger.debug("The magazine in latest English controller: #{@magazines.all}")
     respond_to do |format|
       if @magazines
         format.html { }
         format.json { render json: @magazines}
       else
         format.html{redirect_to action: "index", notice:'Could not find the latest magazine.'}
       end
     end
   end

   def english_archives
     @magazines = Magazine.find_english_archives(params[:id])
     @years = Magazine.find_all_magazine_years('English')
     @Eyears = Magazine.find_all_magazine_years('English')
     @Tyears = Magazine.find_all_magazine_years('Telugu')
     respond_to do |format|

       format.html { }
       format.json { render json: @magazines}

     end
   end

   def latest_telugu_english
     @telugu_latest = Magazine.find_latest_telugu
     @english_latest = Magazine.find_latest_english
     @Eyears = Magazine.find_all_magazine_years('English')
     @Tyears = Magazine.find_all_magazine_years('Telugu')
   end
  def update

    @magazine = Magazine.find(params[:id])

    if (params[:magazine][:filepath])
      tem_filePath = upload_file(params[:magazine][:filepath], "app/assets/magazines")
      params[:magazine][:filepath] = "app/assets/magazines/"+tem_filePath
    end
    if (params[:magazine][:coverpageimage])
      tem_coverPage = upload_file(params[:magazine][:coverpageimage ],"app/assets/images/magazine_cover_pages")
      params[:magazine][:coverpageimage] = "magazine_cover_pages/"+tem_coverPage
    end
    respond_to do |format|

      if @magazine.update_attributes(params[:magazine])

        format.html { redirect_to user_magazines_path(session[:user_id]), notice: 'Magazine was successfully updated.' }
        format.json { head :no_content }

      else
        format.html { render action: "edit" }
        format.json {  }
      end
    end
  end
  def destroy

    @magazine = Magazine.find(params[:id])
    @magazine.destroy

    respond_to do |format|
      format.html { redirect_to user_magazines_path(session[:user_id]), notice: 'Magazine has been successfully deleted.' }
      format.json { head :no_content }
    end
  end
   def upload_file(uploaded_file, directory)
     filename = uploaded_file.original_filename
   #  directory = "public/magazines"
     tem_filePath = File.join(directory, filename)
     if File.exist?(tem_filePath)
       flash[:error] = "File already exists...Do you want to replace it?"
     else
       File.open(tem_filePath, "wb") { |f| f.write(uploaded_file.read) }
     end
     return   filename
   end


   def read_file
     @magazine = Magazine.find(params[:id])

     respond_to do |format|
       if File.exist?(@magazine.filepath)

        format.html { send_file "#{@magazine.filepath}", :type => "application/pdf",
                                :readonly => true, :disposition => "inline" }

       else
         flash[:error] = "File  does not exist!"
         format.html { redirect_to(:back) }

       end
     end
   end

   def user_magazines
     @magazines = Magazine.find_user_magazines(params[:id])
   #  @years = Magazine.find_all_magazine_years
     @Eyears = Magazine.find_all_magazine_years('English')
     @Tyears = Magazine.find_all_magazine_years('Telugu')
   end
end
