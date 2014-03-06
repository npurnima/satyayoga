class Usercourse < ActiveRecord::Base
  attr_accessible :no_of_names_per_day, :course_id, :guide_id, :user_id, :date, :course_no_from,
                  :course_no_to,:user_experiences,:practice_type,:practice_start_date,:practice_time,:rest_time,:status
  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'user_id'
  belongs_to :course,
             :class_name => 'Course',
             :foreign_key => 'course_id'

  validates_presence_of :user_id,:guide_id,:course_id


  def self.find_saadhakas_names(guideid)
    @saadhakas = Userrole.where("role_id =? and  guide_id = ?",3,guideid)

    users = []
    @saadhakas.each do |s|
      users << [User.find(s.user_id).firstname,s.user_id]
    end

    users
  end

  def self.find_all_by_course(courseid)
    @usercourses = Usercourse.where("course_id=?",courseid).order("created_at DESC")
    @usercourses
  end

  def self.find_by_user(userid)
    @usercourses = Usercourse.where("user_id=?",userid).order("course_id,created_at DESC")
    @usercourses
  end

  def self.find_saadhakas_under_a_guide(guideid)
    @saadhakas = Userrole.where("role_id =? and  guide_id = ?",3,guideid)
    @saadhakas
  end

end
