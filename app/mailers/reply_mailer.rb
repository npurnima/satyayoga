class ReplyMailer < ActionMailer::Base

  def send_mail(email)
    @email = email
  #  @receiver = User.find_by_email(@email.email_to)
  #  @sender = User.find_by_email(@email.email_from)
  # receiver_email_with_name = "#{} <#{@receiver.email}>"
  # sender_email_with_name = "#{@sender.firstname} <#{@sender.email}>"
   attachments['yogaschool_logo.png'] =  {:mime_type => 'application/mymimetype',
                                          :content => File.read('public/assets/background_images/logo-blue-and yellow(1).jpg') }
    mail(to:@email.email_to, cc:@email.email_cc, bcc:@email.email_bcc, from:@email.email_from , subject: "#{@email.email_subject}")
  end

   def contact_guide(email)
     @email = email
     mail(to:@email.email_to, from:@email.email_from , subject: "#{@email.email_subject}")

   end
end
