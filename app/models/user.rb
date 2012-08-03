class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable and :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :dragon_stamps, :role_id

  #attr_accessor :chapter_id

  has_many :characters
  has_many :members

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.data_import data, chapter_location
    c = Chapter.find_by_location(chapter_location)
    count = 0
    email_count = 0
    imported_count = 0
    data.each do |row|
      hash = {}
      goblins = row[:Goblin] 
      hash['first_name'] = row[:'First Name']
      hash['last_name'] = row[:'Last Name']
      hash['email'] = row[:'Email Name']
      hash['password'] = 'temp1234'
      hash['password_confirmation'] = 'temp1234'
      hash['role_id'] = 1
      if hash['first_name'].blank?
        puts "record: #{count} not imported, missing first name: #{hash['first_name']}, #{hash['last_name']}, #{hash['email']}"
        import = false
      elsif hash['last_name'].blank?
        puts "record: #{count} not imported, missing last name: #{hash['first_name']}, #{hash['last_name']}, #{hash['email']}"
        import = false
      elsif hash['email'].blank?
        hash['email'] = hash['first_name'] + '_' + hash['last_name'] + '@' + c.name + '.com'
        email_count += 1
        import = true
      else
        import = true
      end
      if import
        us = User.find_by_first_name_and_last_name(hash['first_name'], hash['last_name'])
        us = User.create hash unless us
        Member.data_import c.id, us.id, goblins.to_i
        StampTrack.data_import c.id, us.id, goblins.to_i
        imported_count += 1
      end
      count += 1
    end
    puts "#{email_count}: records missing emails, defaults created <first_name>_<last_name>@#{c.name}.com"
    puts "#{count}: total records, #{imported_count}: records imported"
  end

  def self.all_for_given_members(members)
    users = []
    members.each do |m|
      users << User.find(m.user_id)
    end
    users
  end

  def all_characters_for_user
    chars = Character.find_all_by_user_id(self.id)
  end

  def name
    self.first_name + ' ' + self.last_name
  end

  def all_attendees
    characters = Character.find_all_by_user_id(id)
    attendees = []
    characters.each do |c|
      attendees += Attendee.find_all_by_character_id(c)
    end
    attendees
  end

end
