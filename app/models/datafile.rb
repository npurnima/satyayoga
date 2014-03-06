class Datafile < ActiveRecord::Base
   attr_accessible :filepath,:owner,:title
   belongs_to :user,
              :class_name => 'User',
              :foreign_key => 'owner'

   def self.find_user_files(userid)
     @datafiles = Datafile.where("owner=?",userid).order("updated_at")
     @datafiles
   end


end