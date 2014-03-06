class ApplicationController < ActionController::Base

  @page_title = "Welcome To Piduguralla Yogaschool"
  protect_from_forgery

  before_filter :search_string, :first_two_upcoming_events

  def authorize_user
   # session[:original_uri] = :back
    if !session[:user_id]
      redirect_to user_signin_path(0), notice:"Please sign in to access the action"
    end
  end

  def admincheck
    if !(session[:user_id] && session[:privilage] ==1)
      redirect_to homepages_path, notice:"Sorry! You are not authorised to access this section. Admin can only perform this action. "
    end
  end

  def guidecheck
    if !(session[:user_id] && session[:privilage] <=2)
      redirect_to homepages_path, notice:"Sorry! you are not authorised to access this section. A Guide can only perform this action"
    end
  end

  def saadhakacheck
    if !(session[:user_id] && session[:privilage] <=3)
      redirect_to homepages_path, notice:"Sorry! you are not authorised to access this section. A Saadhaka can only perform this action "
    end
  end


  def search_string
    @events = Event.search(params[:search])
    @search_events = @events.all
  end

  def first_two_upcoming_events
    @upcoming_events = Event.find_all_upcoming_events.limit(2)
  end

  def latest_two_telugu_magazines
    @telugu_latest = Magazine.all
  end

  def signin
    #logger.debug("value of username:")
  end
end
