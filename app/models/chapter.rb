class Chapter < ActiveRecord::Base
  attr_accessible :email, :location, :name, :owner

  has_many :member

  validates_presence_of :name
  validates_presence_of :owner
  validates_presence_of :email
  validates_presence_of :location
end
