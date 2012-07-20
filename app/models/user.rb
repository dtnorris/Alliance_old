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

  def all_patrons_xps
    characters = Character.find_all_by_user_id(id)
    patron_xps = []
    characters.each do |c|
      patron_xps += PatronXp.find_all_by_character_id(c)
    end
    patron_xps
  end

end
