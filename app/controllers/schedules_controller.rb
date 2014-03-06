class SchedulesController < ApplicationController
 #layout'index'
 before_filter :guidecheck, :except=> [:index]

  def index
    @schedules = Schedule.get_all_event_schedules(params[:id])
    @event = Event.find(params[:id])

  end

  def show
    @schedule = Schedule.find(params[:id])

  end


  def new
    @schedule = Schedule.new
    @event = Event.find(params[:id])
    @courses = Course.all
    @dates = @event.get_event_dates

    @schedules = Schedule.get_all_event_schedules(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end

 def multiple_schedules
   @event = Event.find(params[:id])
   @courses = Course.all
   @dates = Schedule.get_event_dates(params[:id])
   @schedule1,@schedule2,@schedule3,@schedule4,@schedule5,@schedule6 = Schedule.new

 end

  # GET /schedules/1/edit
  def edit
    @schedule = Schedule.find(params[:id])
    @event = Event.find(@schedule.event_id)
  end

  # POST /schedules
  # POST /schedules.json
  def create

    @schedule = Schedule.new(params[:schedule])
    @schedule.event_id = params[:id]
    @schedule.date = params[:date]
    respond_to do |format|
      if @schedule.save
      #  format.html { redirect_to new_schedule_path(params[:id],params[:date]), notice: 'Schedule was successfully created.' }
        format.html { redirect_to event_path(params[:id]), notice: 'Schedule was successfully created.' }

      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

 def create_multiple

   if params[:schedule1][:title] != nil
     @schedule1 = Schedule.new(params[:schedule1])
     @schedule1.event_id = params[:id]
     @schedule1.save

     if params[:schedule2][:title] != nil
       @schedule2 = Schedule.new(params[:schedule2])
       @schedule2.event_id = params[:id]
       @schedule2.save

       if params[:schedule3][:title] != nil
         @schedule3 = Schedule.new(params[:schedule3])
         @schedule3.event_id = params[:id]
         @schedule3.save

         if params[:schedule4][:title] != nil
           @schedule4= Schedule.new(params[:schedule4])
           @schedule4.event_id = params[:id]
           @schedule4.save

           if params[:schedule5][:title]!= nil
             @schedule5 = Schedule.new(params[:schedule5])
             @schedule5.event_id = params[:id]
             @schedule5.save

             if params[:schedule6][:title] != nil
               @schedule6 = Schedule.new(params[:schedule6])
               @schedule6.event_id = params[:id]
               if @schedule6.save
                 redirect_to event_path(params[:id]), notice: ' The schedules has been successfully added to the event.'
               end
             else
               redirect_to event_path(params[:id]), notice: 'The schedules has been successfully added to the event.'
             end
           else
             redirect_to event_path(params[:id]), notice: 'The schedules has been successfully added to the event.'
           end
         else
           redirect_to event_path(params[:id]), notice: 'The schedules has been successfully added to the event.'
         end
       else
         redirect_to event_path(params[:id]), notice: 'The schedules has been successfully added to the event.'
       end
     else
       redirect_to event_path(params[:id]), notice: 'The schedules has been successfully added to the event.'
     end
   else
     redirect_to new_schedule_path(params[:id]), notice: 'Please Add the schedules to the event. '
   end



 end
  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to event_path(@schedule.event_id), notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :no_content }
    end
  end

  def event_schedule
    @dates = Schedule.get_event_dates(params[:id])
    @schedules = Schedule.get_all_event_schedules(params[:id])

  end
end
