class Email < ActiveRecord::Base
  attr_accessible :email_attachment, :email_bcc, :email_body, :email_cc, :email_from, :email_subject, :email_to

  validates_presence_of :email_from, :email_body, :email_to
end
