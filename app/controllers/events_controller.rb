class EventsController < ApplicationController
 # layout 'index'
  before_filter :authorize_user, :except => [:index,:show, :upcoming_events]
  before_filter :guidecheck, :except => [:index, :show, :upcoming_events]

  def index
    @search = Event.search(params[:search])
    @events = @search.all

  #  @upcoming_events = Event.find_all_upcoming_events.limit(2)
    @special_events = Event.find_all_special_events.paginate(:page => params[:page], :per_page => 10)
    @regular_events = Event.find_all_regular_events.paginate(:page => params[:page], :per_page => 10)
    @past_events = Event.find_all_past_events.paginate(:page => params[:page], :per_page => 10)

  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @eventcomments = Eventcomment.find_comments_by_event(params[:id])
    @eventcomment = Eventcomment.new
    @schedules = @event.schedules.get_all_event_schedules(params[:id])
    @dates = @event.schedules.get_event_dates(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.owner = session[:user_id]
    respond_to do |format|
      if @event.save
        @users =  User.find_all_email_subscribers()
        @users.each do |user|
            UserMailer.new_event_notification(@event,user).deliver
        end

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def first_two_upcoming_events
    @upcoming_events = Event.find_all_upcoming_events.limit(2)
  end

#  def upcoming_events
#    @events = Event.find_all_upcoming_events
#    logger.debug (" The Number of events from the controller:#{@events}")
#    @eventcomment = Eventcomment.new()
#    @eventcomments = Eventcomment.all
#    respond_to do |format|
#      format.html
#    end

#  end


  def user_events
    @user_events = Event.find_all_user_events(params[:id])
  end
end

private

def time_in_am_pm(stime)
    if stime == nil
      return ' '
    end
    stime.min == 0?  m='00': m = stime.min

    if stime.hour == 0  || stime.hour%12 == 0
        return  "#{12}:#{m} PM"
      else if stime.hour > 12
             return  "#{stime.hour%12}:#{m} PM"
           else  return "#{stime.hour}:#{m} AM"
           end
      end
 end