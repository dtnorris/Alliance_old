class Death < ActiveRecord::Base
  attr_accessible :buyback, :chapter_id, :character_id, :regen_css

  belongs_to :character
  belongs_to :chapter

  validates_presence_of :character_id
  validates_presence_of :chapter_id

  def self.regular death_array
    death_array.inject([]) { |a,d| a << d if d.regen_css == false and d.buyback == false; a }.count
  end

  def self.regen_css death_array
    death_array.inject([]) { |a,d| a << d if d.regen_css == true; a }.count
  end

  def self.buyback death_array
    death_array.inject([]) { |a,d| a << d if d.buyback == true; a }.count
  end
end
