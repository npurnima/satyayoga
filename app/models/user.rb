class User < ActiveRecord::Base

 # paginates_per 1


  attr_accessible :firstname,:lastname,:username,:password,:date_of_birth,:street_address,:city_address,:state,
                  :zip_code,:country,:email,:phone_number,:photo,:voice_request,:salt,:terms_accepted,
                  :confirm_password,:last_succ_login,:email_subscriber
  attr_protected :id, :salt
  #attr_accessor :confirm_password

  has_one :userrole,
          :class_name => 'Userrole',
          :foreign_key => 'user_id'

  has_many :usercourses,
           :class_name => 'Usercourse',
           :foreign_key => 'user_id'




  SECRET_QUESTIONS=[
      # Displayed                     Stored in DB
      ["What is your mother's maiden name?", "What is your mother's maiden name?"],
      ["What is your spouse name?",  "What is your spouse name?"],
      ["Who is your favorite person?", "Who is your favorite person?"],
      ["What is your favorite color?", "What is your favorite color?"],

  ]

  validates_presence_of :firstname, :lastname, :email, :date_of_birth
  validates_uniqueness_of :email, :username
  validates_length_of :username, :within => 6..40
  validates_length_of :password, :within => 5..40
  validates_length_of :phone_number,:within => 10..14, :allow_blank => true
  validates_format_of :photo, :with    => %r{\.(gif|jpg|png|jpeg)$}i, :allow_blank => true,
                                             :message => "must be a URL for a GIF, JPG, or PNG image"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true
  validates_confirmation_of :password
  validates_acceptance_of :terms_accepted,
                          :on => :create,
                          :message => "Please accept the terms to proceed"



  before_create :hash_password
  before_update :hash_password

  after_create :set_userrole_to_simple_user

  def hash_password
    self.firstname = firstname.capitalize
    self.lastname = lastname.capitalize
      if password.present?
          self.salt= User.make_salt(password.length)
          self.confirm_password = self.password = User.encrypt(password,self.salt)

      end
  end

  def set_userrole_to_simple_user

      @userrole = Userrole.new()
      @userrole.user_id = self.id
      @userrole.role_id = 4
      @userrole.save
  end

  def self.authenticate(uname,password)
    if user = find_by_username(uname)

      temp_password = User.encrypt(password,user.salt)

      logger.debug "user.salt value: #{user.salt}"
      logger.debug "user,password value: #{user.password}"
      logger.debug "temp,password value: #{temp_password}"
      if user.password == temp_password
        $last_login_date  = user.last_succ_login
        user.update_column('last_succ_login',DateTime.now)
        logger.debug("user last login_date and time:#{$last_login_date}")
       return user
      end
     end

  end
  def self.find_user_privilage(userid)
    @userrole = Userrole.find_by_user_id(userid)

    if @userrole.present?
      return @userrole.role_id
    else
      return 4
    end

  end

  def self.find_user_role(userid)
    if @userrole = Userrole.find_by_user_id(userid)
      @role = Role.find(@userrole.role_id)
      @role.name
    end
  end
 # def self.find_all_saadhakas
 #   @userroles = Userrole.find_all_saadhakas

  #end
  def self.change_password(uname,new_password)
    @user = User.find_by_username(uname)
    if @user && new_password.present?

        salt= User.make_salt(new_password.length)
        confirm_password = password = User.encrypt(new_password,salt)
        @user.salt = salt
        @user.confirm_password = confirm_password
        @user.password = password
      @user.save
      UserMailer.changed_password_email(@user).deliver
      return true
    else
      return false
    end


  end

  def send_new_password(newpassword)
    new_pass_salt = User.make_salt(newpassword.length)
    new_pass = User.encrypt(newpassword,new_pass_salt)
    self.password = self.confirm_password= new_pass
    self.save
    UserMailer.forgot_password_email(self.email, self.username, new_pass)
  end


  def self.find_all_email_subscribers
         @users = User.where("email_subscriber = ?",true)
         logger.debug"The list of subscribed users are: #{@users.length}"
    return @users
  end

  def self.change_email_subscription_status(uid,status)
    user = User.find_by_id(uid)

    user.update_column('email_subscriber', status)

    user.save
  end



  protected

  def self.encrypt(pass, salt)

   verify_pass = Digest::SHA1.hexdigest("#{pass}#{salt}")

   logger.debug " salt value from encrypt: #{salt}"
   logger.debug " password form encrypt: #{pass} "
   logger.debug " encrypted value from encrypt: #{verify_pass}"
   return verify_pass
 end

  # @param [Object] len
 def self.make_salt(len)
    #generates a random string consisting of chars and digits

    chars = [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    msalt = (0..len).map {chars[rand(chars.length)]}.join
    logger.debug "random salt value: #{msalt}"
    return msalt

  end

end
