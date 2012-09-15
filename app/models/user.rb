class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable and :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :dragon_stamps

  attr_accessor :role_id

  has_many :characters
  has_many :members
  has_many :assignments
  has_many :stamp_tracks

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name

  UNRANSACKABLE_ATTRIBUTES = ['id','dragon_stamps','role_id','encrypted_password','reset_password_token','reset_password_sent_at','remember_created_at','sign_in_count','current_sign_in_at','last_sign_in_at','current_sign_in_ip','last_sign_in_ip']

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

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
      if hash['first_name'].blank?
        puts "record: #{count} not imported, missing first name: #{hash['first_name']}, #{hash['last_name']}, #{hash['email']}" unless Rails.env = 'test'
        import = false
      elsif hash['last_name'].blank?
        puts "record: #{count} not imported, missing last name: #{hash['first_name']}, #{hash['last_name']}, #{hash['email']}" unless Rails.env = 'test'
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
        Assignment.data_import us.id
        Member.data_import c.id, us.id, goblins.to_i
        StampTrack.data_import c.id, us.id, goblins.to_i
        imported_count += 1
      end
      count += 1
    end
    puts "#{email_count}: records missing emails, defaults created <first_name>_<last_name>@#{c.name}.com" unless Rails.env = 'test'
    puts "#{count}: total records, #{imported_count}: records imported" unless Rails.env = 'test'
  end

  def self.all_for_given_members(members)
    users = []
    members.each do |m|
      users << User.find(m.user_id)
    end
    users
  end

  def add_default_associations
    self.dragon_stamps = 0
    self.save
    member = Member.where(user_id: self.id).first
    if Member.where(user_id: self.id, chapter_id: 1) != nil
      Member.create(user_id: self.id, chapter_id: 1, goblin_stamps: 0)
    end
    Character.create(
      user_id: self.id, 
      chapter_id: member.chapter.id,
      build_points: 15, 
      experience_points: 0, 
      spent_build: 0,
      name: "#{self.first_name} #{member.chapter.name} Blank", 
      race_id: 11, #Human
      char_class_id: 1 #Fighter
    )
  end

  def member_of_chapter chapter
    self.members.each do |m|
      if m.chapter_id == chapter.id
        return true
      end
    end
    return false
  end

  def all_characters_for_user
    chars = Character.find_all_by_user_id(self.id)
  end

  def name
    "#{self.first_name} #{self.last_name}"
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
