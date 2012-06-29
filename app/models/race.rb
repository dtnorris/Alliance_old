class Race < ActiveRecord::Base
  attr_accessible :name, :body_mod
  has_many :characters
end
