class Race < ActiveRecord::Base
  attr_accessible :name
  belongs_to :character
end
