class Role < ActiveRecord::Base
  attr_accessible :name
  has_many :userroles,
           :class_name => 'Userrole',
           :foreign_key => 'role_id'

 # def self.privilaged_roles
  #  @roles = Role.all
   #    @proles = Role.find(:conditions => ['name != ?', "Admin"])
      # :conditions => ['status_id = "3" AND date_fixed > ? AND date_fixed <= ? AND product_id = ?', start_date, end_date, params[:id]]
  #end
end
