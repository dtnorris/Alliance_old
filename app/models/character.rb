class Character < ActiveRecord::Base
  attr_accessible :build_points, :experience_points, :name, :race_id, :character_skill_id
  belongs_to :race
  belongs_to :character_skill

  after_save :create_skills_if_none

  def create_skills_if_none
    unless self.character_skill
      c = CharacterSkill.create
      self.character_skill_id = c.id
      self.save
    end
  end
end
