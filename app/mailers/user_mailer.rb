class UserMailer < ActionMailer::Base
  default from: "piduguralla.yagaschool@gmail.com"
 # layout 'user_mailer_layout'

  def welcome_email(user)
    @user = user

    @url  = 'http://yogaschool.herokuapp.com/users/0/signin'

    email_with_name = "#{@user.firstname} <#{@user.email}>"

    attachments['yogaschool_logo.png'] =  {:mime_type => 'application/mymimetype',
                                           :content => File.read('/assets/background_images/logo-blue-and yellow(1).jpg') }

        mail(to: email_with_name, subject: 'Welcome to  Raaja Yoga School')

  end

  def forgot_password_email(user)
      @user = user

      @url = 'http://yogaschool.herokuapp.com/users/0/change_password'

      email_with_name = "#{@user.firstname} <#{@user.email}>"

      attachments['yogaschool_logo.png'] =  {:mime_type => 'application/mymimetype',
                                             :content => File.read('/assets/background_images/logo-blue-and yellow(1).jpg') }
     mail(to: email_with_name, subject: 'Password Change request confirmation from Raaja Yoga School')
  end

  def changed_password_email(user)
    @user = user

    @url = 'http://yogaschool.herokuapp.com/users/0/signin'

    email_with_name = "#{@user.firstname} <#{@user.email}>"

    attachments['yogaschool_logo.png'] =  {:mime_type => 'application/mymimetype',
                                           :content => File.read('/assets/background_images/logo-blue-and yellow(1).jpg') }
    mail(to: email_with_name, subject: 'Confirmation of Change of Password in Raaja Yoga School')
  end

  def  new_event_notification (event,user)
     @event = event
     @user = user
     @url ="http://yogaschoo.herokuapp.com/events/#{@event.id}"
     attachments['yogaschool_logo.png'] =  {:mime_type => 'application/mymimetype',
                                            :content => File.read('/assets/background_images/logo-blue-and yellow(1).jpg') }

        email_with_name = "#{@user.firstname}<#{@user.email}>"

        mail(to: email_with_name, subject: 'New Upcoming Event in Raaja Yoga School')


  end

  def  new_magazine_notification (magazine,user)
    @magazine = magazine

    @user = user
    @url ="http://yogaschoo.herokuapp.com/magazines/latest_telugu_english"
    attachments['yogaschool_logo.png'] =  {:mime_type => 'application/mymimetype',
                                           :content => '' }

      email_with_name = "#{@user.firstname}<#{@user.email}>"

      mail(to: email_with_name, subject: 'Latest Magazine has been updated in Raaja Yoga School')


  end

  def  new_comment_notification (expcomment)

    @expcomment = expcomment
    @user = User.find(Experience.find(@expcomment.exp_id).owner)

    attachments['yogaschool_logo.png'] =  {:mime_type => 'application/mymimetype',
                                           :content => File.read('/assets/background_images/logo-blue-and yellow(1).jpg') }

    @experience = Experience.find(@expcomment.exp_id)
    @sender = User.find(@expcomment.owner)
    @url ="http://yogaschoo.herokuapp.com/experiences/#{@experience.id}"

    if @user.email_subscriber == true
      email_with_name = "#{@user.firstname}<#{@user.email}>"
      sender_email_with_name = "#{@sender.firstname} <#{@sender.email}>"
      mail(to: email_with_name, from: sender_email_with_name, subject: 'A comment has been added to your post in Raaja Yoga School')
    end

  end


end
