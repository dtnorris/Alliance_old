class Chapter < ActiveRecord::Base
  attr_accessible :email, :location, :name, :owner

  has_many :member
end
