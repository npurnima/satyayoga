class Userrole < ActiveRecord::Base
  attr_accessible :assigned_by, :role_id, :user_id,:guide_id
  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'user_id'
  belongs_to :role,
             :class_name => 'Role',
             :foreign_key => 'role_id'

   def self.find_all_roles(roleid)
    @userroles = Userrole.where("role_id = ?", roleid)
     logger.debug("list of all saadhakas #{@userroles.all}")
     return @userroles
   end

  def self.find_guides_names
    @guides = Userrole.find_all_roles(2)

    guides = []
    @guides.each do |g|
      guides << [User.find(g.user_id).firstname,g.user_id]
    end

    guides
  end

  def self.find_all_saadhakas_by_guide(guideid)
      @saadhakas = Userrole.where("guide_id= ?",guideid)
      @saadhakas
  end
end
