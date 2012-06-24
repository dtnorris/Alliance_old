class CharacterSkill < ActiveRecord::Base
  attr_accessible :alchemy, :archery, :assassinate, :back_attack, :backstab, :blacksmith, :break_command, :celestial_level_1, :celestial_level_2, :celestial_level_3, :celestial_level_4, :celestial_level_5, :celestial_level_6, :celestial_level_7, :celestial_level_8, :celestial_level_9, :claws, :create_potion, :create_scroll, :create_trap, :critical_attack, :disarm, :dodge, :earth_level_1, :earth_level_2, :earth_level_3, :earth_level_4, :earth_level_5, :earth_level_6, :earth_level_7, :earth_level_8, :earth_level_9, :evade, :eviscerate, :first_aid, :florentine, :formal_celestial, :formal_earth, :gypsy_curse, :healing_arts, :herbal_lore, :legerdemain, :merchant, :one_handed_blunt, :one_handed_edged, :one_handed_master, :parry, :polearm, :racial_assassinate, :racial_dodge, :racial_proficiency, :racial_slay, :read_and_write, :read_magic, :resist_binding, :resist_command, :resist_element, :resist_fear, :resist_magic, :resist_necromancy, :resist_poison, :riposte, :shatter, :shield, :slay, :small_weapon, :staff, :stun_limb, :style_master, :teacher, :terminate, :thrown_weapon, :two_handed_blunt, :two_handed_master, :two_handed_sword, :two_weapons, :waylay, :weapon_master, :weapon_proficiency, :wear_extra_armor
  has_one :character

  #after_create :set_integers_to_zero

  def add_skill(attr_name)
    if attributes[attr_name] == true
      return
    elsif attributes[attr_name] && attributes[attr_name].integer?
      attributes[attr_name] += 1
    else
      1
    end
  end

  def self.display_val(attr_name)
    case
    when attr_name == 'created_at'
      return false
    when attr_name == 'updated_at'
      return false
    when attr_name == 'id'
      return false
    else
      return true
    end
  end

end
