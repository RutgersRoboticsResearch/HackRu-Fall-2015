class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:mlh]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :profile_name, :avatar,:school_name,
                  :school_year, :git_account, :tshirt_size, :diet, :special_needs, :resume
  
  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :resume, presence: true
  validates :git_account, presence: true
  
  has_many :activities                          
  has_many :albums
  has_many :pictures
  has_many :statuses
  has_many :user_friendships
  has_many :friends, through: :user_friendships,
                     conditions: { user_friendships: { state: 'accepted' } }

  has_many :pending_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'pending' }
  has_many :pending_friends, through: :pending_user_friendships, source: :friend
  
  has_many :requested_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'requested' }
  has_many :requested_friends, through: :requested_user_friendships, source: :friend
  
  has_many :blocked_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'blocked' }
  has_many :blocked_friends, through: :blocked_user_friendships, source: :friend
  
  has_many :accepted_user_friendships, class_name: 'UserFriendship',
                                      foreign_key: :user_id,
                                      conditions: { state: 'accepted' }
  has_many :accepted_friends, through: :accepted_user_friendships, source: :friend

  has_attached_file :avatar , styles: {
    large: "800x800>", medium: "300x200", small: "260x180", thumb: "80x80#"

  }

  has_attached_file :resume

  #def self.get_gravatars
  #  all.each do |user|
  #    if !user.avatar?
  #      user.avatar = URI.parse(user.gravatar_url)
  #      user.save
  #      print "."
  #    end
  #  end 
  #end

  def full_name
    first_name + " " + last_name
  end

  def to_param
    profile_name
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}"
  end

  def has_blocked?(other_user)
    blocked_friends.include?(other_user)
  end

  def create_activity(item, action)
    activity = activities.new
    activity.targetable = item
    activity.action = action
    activity.save
    activity
  end

  def send_welcome_email
    UserNotifier.welcome_email(id).deliver
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session["devise.mlh_data"] && session["devise.mlh_data"]["info"]
        data = session['devise.mlh_data']['info']

        user.uid = session['devise.mlh_data']['uid']
        user.provider = :mlh
        user.password = Devise.friendly_token[0,20]
        user.profile_name = "#{data.first_name}#{session['devise.mlh_data']['uid']}"
        data.special_needs if user.special_needs.blank?
        user.email = data.email if user.email.blank?
        user.first_name = data.first_name if user.first_name.blank?
        user.last_name = data.last_name if user.last_name.blank?
        user.school_name = data.school.name if user.school_name.blank?
        user.tshirt_size = data.shirt_size if user.tshirt_size.blank?
        user.diet = data.dietary_restrictions if user.diet.blank?
        user.special_needs = data.special_needs if user.special_needs.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.profile_name = "#{auth.info.first_name}#{auth.uid}"
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.school_name = auth.info.school.name
      user.tshirt_size = auth.info.shirt_size
      user.diet = auth.info.dietary_restrictions
      user.special_needs = auth.info.special_needs
    end
  end

end
