class Chapter < ActiveRecord::Base
  attr_accessible :email, :location, :name, :owner

  has_many :event
  has_many :character
  has_many :member
  has_many :stramp_track

  validates_presence_of :name
  validates_presence_of :owner
  validates_presence_of :email
  validates_presence_of :location

  def self.data_import chapter
    Chapter.create(name: chapter[:name], owner: chapter[:owner], email: chapter[:email], location: chapter[:location])
  end
end
