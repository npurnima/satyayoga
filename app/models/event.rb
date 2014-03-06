class Event < ActiveRecord::Base
  attr_accessible :name,:description,:location,:starttime,:endtime,:street_address,:owner,
                  :city_address,:state,:zip_code,:country,:email,:phone_number,:event_type

  validates_presence_of :name, :location, :starttime, :event_type
  validates_size_of :phone_number, :within => 10..14,:allow_blank => false,
                    :minimum => [(0..9),(0..9),(0..9),(0..9),(0..9),(0..9),(0..9),(0..9),(0..9),(0..9)]

  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'owner'

  has_many :schedules,
           :class_name => 'Schedule',
           :foreign_key => 'event_id'

  def self.find_all_upcoming_events
    end_date = Date.today + 90
    if connection.adapter_name == 'PostgreSQL'
      @events = Event.where("\"endtime\" " " >= ? and \"starttime\" "  " <= ? ",Date.today.to_date,end_date.to_date ).order("\"starttime\"")
    else
      @events = Event.where("endtime >= ? and starttime <= ? ",Date.today.to_date,end_date.to_date ).order("starttime")
    end
  end

  def self.find_all_special_events

    if connection.adapter_name == 'PostgreSQL'
      @special_events = Event.where("\"starttime\" >= ? and event_type = ?", Date.today.to_date, "Special").order("\"starttime\"")
    else
      @special_events = Event.where("starttime >= ? and event_type = ?", Date.today.to_date, "Special").order("starttime")
    end
  end

  def self.find_all_regular_events

    if connection.adapter_name == 'PostgreSQL'
      @regular_events = Event.where("\"starttime\" >= ? and event_type = ?", Date.today.to_date, "Regular").order("\"starttime\"")
    else
      @regular_events = Event.where("starttime >= ? and event_type = ?", Date.today.to_date, "Regular").order("starttime")
    end
  end

  def self.find_all_past_events

    if connection.adapter_name == 'PostgreSQL'
      @past_events = Event.where("\"starttime\" <= ? ", Date.today.to_date).order("\"starttime\""" DESC")
    else
      @past_events = Event.where("starttime <= ? ", Date.today.to_date).order("starttime DESC")
    end
  end
  def  self.find_all_user_events(userid)
    if connection.adapter_name == 'PostgreSQL'
      @userevents = Event.where("owner = ?",userid).order("\"starttime\"")
    else
      @userevents = Event.where("owner = ?",userid).order("starttime")
    end
  end

end
