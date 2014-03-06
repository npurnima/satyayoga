class Practice < ActiveRecord::Base
  attr_accessible :course_from_number, :course_id, :course_to_number, :date, :experience, :owner, :guide_id
  belongs_to :course,
             :class_name => 'Course',
             :foreign_key => 'course_id'

  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'guide_id'

  def self.find_user_practices(guideid)
    @practices = Practice.where("guide_id=?",guideid).order("date DESC")
  end
end
