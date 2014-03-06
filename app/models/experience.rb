class Experience < ActiveRecord::Base
  attr_accessible :description, :no_of_views, :owner, :topic

  has_many :expcomments,
           :class_name => 'Expcomment',
           :foreign_key => 'exp_id'
end
