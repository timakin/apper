class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :password, :uid, :provider
  # attr_accessible :title, :body

  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  has_many :items
  has_many :comments

  acts_as_followable


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
        user.name = data["name"]
      end
    end
  end


  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password.
      User.create!(:email => data.email, :name => data.name, :password => Devise.friendly_token[0,20], :provider => access_token.provider, :uid => access_token.uid)
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(:email => data.email).first
      user
    else # Create a user with a stub password.
      User.create!(:email => data.email, :name => data.name, :password => Devise.friendly_token[0,20], :provider => access_token.provider, :uid => access_token.uid)
    end
  end


end
