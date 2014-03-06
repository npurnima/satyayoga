class Eventcomment < ActiveRecord::Base
  attr_accessible :comment, :event_id, :user_id
  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'user_id'

  belongs_to :event,
             :class_name => 'Event',
             :foreign_key => 'event_id'

  validates_presence_of :comment

  def self.find_comments_by_event(eventid)
    @eventcomments = Eventcomment.where("event_id=?",eventid).order("created_at")
    @eventcomments
  end

  def self.find_comments_by_user(userid)
    @eventcomments = Eventcomment.where("user_id=?",userid)
  end
end
