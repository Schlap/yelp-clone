class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :login

  has_many :reviews, dependent: :destroy

  validates :username, presence: true, uniqueness: {
    case_sensitive: false
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
