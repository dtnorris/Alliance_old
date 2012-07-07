class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable and :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :dragon_stamps

  has_many :character
  has_many :member

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.find_all_memberships
    Member.find_all_by_user_id(id)
  end
end
