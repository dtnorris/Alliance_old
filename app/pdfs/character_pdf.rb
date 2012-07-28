require 'prawn/measurement_extensions'

class CharacterPdf < Prawn:: Document
  def initialize(character)
    super(page_layout: :landscape)
    @character = character
    @chapter = Chapter.find(@character.home_chapter)
    @user = User.find(@character.user_id)
    @member = Member.find_by_chapter_id_and_user_id(@chapter.id, @user.id)
    @chararacter_skills = CharacterSkill.find_all_by_character_id(@character.id)
    card_size_consts
    card_outline
    card_text
  end

  def card_text
  end

  def card_outline
    bounding_box [0,550], width: @total_width, height: @total_height do
      stroke_bounds
      main_info
      racial_per_day_skills
      continuous_skills
      craftsman_skills
      life_tag
    end
  end

  def main_info 
    bounding_box [@main_orig,@total_height], width: @main_width, height: @total_height do
      stroke_bounds
      main_chapter_name
      main_member_info
      main_character_info
      main_death_info
      main_build_info
      main_spell_info
    end
  end

  def main_spell_info
    bounding_box [@main_orig,@total_height], width: @main_width, height: @main_spell_height do
      stroke_bounds
      move_down 2.8.in
      total_spell_array = 10
      celestial = ["Celestial"]
      celestial += CharacterSkill.all_spells(@character,"Celestial")
      if celestial.length != total_spell_array
        count = total_spell_array - celestial.length
        count.times { |x| celestial += [nil] }
      end
      earth = ["Earth"]
      earth += CharacterSkill.all_spells(@character,"Earth")
      if earth.length != total_spell_array
        count = total_spell_array - earth.length
        count.times { |x| earth += [nil] }
      end
      #debugger
      data = [["","1","2","3","4","5","6","7","8","9"],
              celestial,
              earth,
             ]
      table(data) do
        cells.align = :center
        cells.size = 9
        cells.padding = 1
        rows(0).padding_bottom = 2
        #rows(1..2).padding_left = 2
        #rows(1..2).padding_right = 2
        rows(1..2).columns(1..9).width = 13.5
        rows(0..2).columns(1..9).align = :center
        column(0).padding_left = 0.125.in
        column(0).borders = []
        column(0).align = :right
        column(0).padding_right = 4
        rows(0).columns(0..9).borders = []
      end
      move_down 0.1.in
      total_c_spells = 0
      celestial.each { |x| if x != 'Celestial' && x != nil then total_c_spells += x end }
      wand_dmg = 1
      wand_dmg += celestial[9] unless celestial[9] == nil
      text "Total Wand Charges: #{total_c_spells},    Wand Damage: #{wand_dmg}",
          size: 8,
          indent_paragraphs: 2
    end
  end

  def main_build_info
    bounding_box [@main_orig,@total_height], width: @main_width, height: @main_build_height do
      stroke_bounds
      move_down 2.205.in
      data = [["","Used: ","Free: ","Total: "],
              ["Build:",@character.spent_build,@character.build_points - @character.spent_build,@character.build_points],
              ["Experience:","","",@character.experience_points]
             ]
      table(data) do
        cells.padding = 1
        cells.size = 9
        rows(0).font_style = :bold
        columns(0).font_style = :bold
        columns(0).align = :right
        columns(0).padding_left = 0.25.in
        columns(1..3).align = :center
        rows(0..2).columns(0..3).borders = []
      end
    end
  end

  def main_death_info
    bounding_box [@main_orig,@total_height], width: @main_width, height: @main_death_height do
      stroke_bounds
      move_down 1.8.in
      #TODO calculate off character death values
      text "<b>Deaths</b> 0           <b>Bought Back</b> 0",
          size: 10,
          indent_paragraphs: 5,
          inline_format: :true
      move_down 0.05.in
      text "<b>Deaths while Regen/Css:</b> 0",
          size: 10,
          indent_paragraphs: 5,
          inline_format: :true
    end
  end

  def main_character_info
    bounding_box [@main_orig,@total_height], width: @main_width, height: @main_character_height do
      stroke_bounds
      move_down 0.975.in #start the text in the box
      #text "<b>Character:</b> #{@character.name}",
      text @character.name,
          size: 10,
          indent_paragraphs: 5,
          inline_format: :true
      body_boxes
      move_down 4
      #text "<b>Race:</b> #{Race.find(@character.race_id).name}",
      text "#{Race.find(@character.race_id).name}",
          size: 10,
          indent_paragraphs: 5,
          inline_format: :true
      move_down 1
      #text "<b>Class:</b> #{CharClass.find(@character.char_class_id).name}",
      text "#{CharClass.find(@character.char_class_id).name}",
          size: 10,
          indent_paragraphs: 5,
          inline_format: :true
    end
  end

  def body_boxes
    bounding_box [@main_orig + 0.05.in,0.6.in], width: (@main_width - 0.1.in), height: 0.2.in do
      stroke_bounds
      move_down 3.5 #center in the box
      #TODO calculate Earth's bounty body
      text "<b>Base Body</b> #{@character.body_points}  <b>E.Bounty</b> 0  <b>Body</b> #{@character.body_points}",
          size: 9,
          indent_paragraphs: 3,
          inline_format: true
    end
  end

  def main_member_info
    bounding_box [@main_orig,@total_height], width: @main_width, height: @main_member_height do
      stroke_bounds
      move_down 25 #start the text in the box
      text "<b>Member #</b>            #{@member.id.to_s}          #{Time.now.to_date.to_s}", 
          size: 10, 
          indent_paragraphs: 5, 
          inline_format: :true
      move_down 1.5
      text "#{@user.name}",
          size: 10,
          indent_paragraphs: 5
      move_down 1.5
      text "<b>Goblin Stamps:</b>  #{@member.goblin_stamps}  <b>Level:</b> #{(@character.build_points - 5) / 10}",
          size: 10,
          indent_paragraphs: 5,
          inline_format: :true
    end
  end

  def main_chapter_name
    bounding_box [@main_orig,@total_height], width: @main_width, height: @main_ch_height do
      stroke_bounds
      move_down 4.5 #to center the chapter name vertically
      text @chapter.name, 
          size: 15,
          style: :bold, 
          align: :center
    end
  end

  def racial_per_day_skills
    bounding_box [@rpds_orig,@total_height], width: @rpds_width, height: @total_height do
      stroke_bounds
    end
  end

  def continuous_skills 
    bounding_box [@cs_orig,@total_height], width: @cs_width, height: @total_height do
      stroke_bounds
    end
  end

  def craftsman_skills 
    bounding_box [@cf_orig,@total_height], width: @cf_width, height: @total_height do
      stroke_bounds
    end
  end

  def life_tag
    bounding_box [@lt_orig,@total_height], width: @lt_width, height: @total_height do
      stroke_bounds
    end
  end

  def card_size_consts
    # Overal card dimensions
    @total_width = 8.6.in
    @total_height = 3.6.in
    
    # Card section consts
    @main_orig = 0
    @main_width = 2.45.in
    @rpds_orig = 2.45.in
    @rpds_width = 1.7.in
    @cs_orig = 4.15.in
    @cs_width = 1.75.in
    @cf_orig = 5.9.in
    @cf_width = 1.7.in
    @lt_orig = 7.6.in
    @lt_width = 1.in

    #main info box consts
    @main_ch_height = 0.3.in
    @main_member_height = 0.6.in + @main_ch_height
    @main_character_height = 0.85.in + @main_member_height
    @main_death_height = 0.45.in + @main_character_height
    @main_build_height = 0.6.in + @main_death_height
    @main_spell_height = 0.8.in + @main_build_height
  end
end