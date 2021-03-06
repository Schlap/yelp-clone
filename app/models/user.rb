class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :login

  has_many :reviews, dependent: :destroy
  has_attached_file :avatar,
                    styles: { :thumb => "100x100>" },
                    default_url: '/images/:style/missing-user.png',
                    storage: :s3,
                    s3_credentials: Proc.new{|a| a.instance.s3_credentials }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :username, presence: true, uniqueness: {
    case_sensitive: false
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :omniauth_providers => [:facebook]

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.avatar = auth.info.image
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def s3_credentials
    { bucket: 'ch2ch3-yelp', access_key_id: Rails.application.secrets[:access_key_id], secret_access_key: Rails.application.secrets[:secret_access_key] }
  end

end
