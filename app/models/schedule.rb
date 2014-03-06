class Schedule < ActiveRecord::Base
  attr_accessible :end_time, :event_id, :next_event, :start_time, :title, :date

  belongs_to :event,
             :class_name => 'Event',
             :foreign_key => 'event_id'

  REPEAT = [['Everyday',1],
            ['Every week',7],
            ['Once in two weeks',15]]

   EVENTDATES =[]

  validates_presence_of :title

  def self.get_event_dates(eventid)
    @event = Event.find(eventid)

    EVENTDATES.clear
    (@event.starttime.to_date..@event.endtime.to_date).each do |d|
             EVENTDATES<< d.to_date
    end
    return EVENTDATES
  end

  def self.get_all_event_schedules(eventid)

    @schedules =  Schedule.where("event_id=?",eventid).order("start_time ASC")
  end

end
