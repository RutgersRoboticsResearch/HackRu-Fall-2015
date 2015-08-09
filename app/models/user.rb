class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :profile_name, :avatar, :diet, :school_name, :git_account
  
  validates :first_name, presence: true

  validates :last_name, presence: true

 # validates :profile_name, presence: true,
  #                         uniqueness: true,
  #                         format: {
  #                           with: /^[a-zA-Z0-9_-]+$/,
  #                           message: 'Must be formatted correctly.'
  #                         }


  has_attached_file :avatar , styles: {
    large: "800x800>", medium: "300x200", small: "260x180", thumb: "80x80#"

  }

  def full_name
    first_name + " " + last_name
  end

 # def to_param
  #  profile_name
  #end

end