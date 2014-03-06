class Course < ActiveRecord::Base
   attr_accessible :name,:description,:filepath,:owner

  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'owner'
   has_many :usercourses,
            :class_name => 'Usercourse',
            :foreign_key => 'course_id'

  def self.find_user_courses(userid)
    @courses = Course.where("owner=?",userid).order("updated_at")
    @courses
  end

end
