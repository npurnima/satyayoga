class HomepagesController < ApplicationController
 # layout 'index'
  before_filter :authorize_user, :except => [:index,:rule1,:rule2, :rule3,:faq]
 # before_filter :admincheck, :except => [:index,:rule1,:rule2, :rule3, :saadhaka,:guide]
 # before_filter :guidecheck, :except => [:index,:rule1,:rule2, :rule3, :saadhaka,:admin]
 # before_filter :saadhakacheck, :except => [:index,:rule1,:rule2, :rule3, :guide,:admin]
  def index

  end

  def rule1

  end
  def rule2

  end
  def rule3

  end



  def mypage
    @user = User.find(session[:user_id])
    @usercomments = Expcomment.find_all_user_comments(session[:user_id])
    @eventcomments = Eventcomment.find_comments_by_user(session[:user_id])
    @usercourses = Usercourse.find_by_user(session[:user_id])
    @useralbums = Album.find_all_user_albums(session[:user_id])
    @usersaadhakas = Userrole.find_all_saadhakas_by_guide(session[:user_id])
    @userevents = Event.find_all_user_events(session[:user_id])

    @guide = User.find_by_id(Userrole.find_by_user_id(session[:user_id]).guide_id)

  end

end
