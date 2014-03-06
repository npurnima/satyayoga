class Expcomment < ActiveRecord::Base
  attr_accessible :comment_type, :description, :exp_id, :no_of_views, :owner

  belongs_to :experience,
             :class_name => 'Experience',
             :foreign_key => 'exp_id'

  def self.find_all_by_exp_id(expid)
    @expcomments =  Expcomment.where("exp_id=? and comment_type =?",expid,'Public').order("created_at DESC")
    @expcomments
  end

  def self.find_all_private_comments(userid,expid)
    @private_commets = Expcomment.where("exp_id=? and owner=? and comment_type=?",expid,'50','Private').order("created_at DESC")
    @private_commets
  end

  def self.find_all_user_comments(userid)
    @expcomments = Expcomment.where("owner=?",userid)
    @expcomments
  end
end
