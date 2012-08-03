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
  end

  def card_size_consts
    # Overal card dimensions
    @total_width = 9.1.in
    @total_height = 3.6.in
    
    # Card section consts
    @main_orig = 0
    @main_width = 2.55.in
    @rpds_orig = 2.55.in
    @rpds_width = 1.8.in
    @cs_orig = 4.35.in
    @cs_width = 1.8.in
    @cf_orig = 6.15.in
    @cf_width = 1.8.in
    @lt_orig = 7.95.in
    @lt_width = 1.15.in

    #main info box consts
    @main_ch_height = 0.3.in
    @main_member_height = 0.6.in + @main_ch_height
    @main_character_height = 0.85.in + @main_member_height
    @main_death_height = 0.45.in + @main_character_height
    @main_build_height = 0.6.in + @main_death_height
    @main_spell_height = 0.8.in + @main_build_height
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

  def racial_per_day_skills
    bounding_box [@rpds_orig,@total_height], width: @rpds_width, height: @total_height do
      stroke_bounds
      racial_box
      per_day_box
      move_down 5
      ce = CharacterSkill.find_by_character_id_and_skill_id(@character.id, Skill.find_by_name('Formal Celestial').id)
      ea = CharacterSkill.find_by_character_id_and_skill_id(@character.id, Skill.find_by_name('Formal Earth').id)
      if ce
        c_formal = "#{ce.amount} Celestial"
      else
        c_formal = ""
      end
      if ea
        e_formal = "#{ea.amount} Earth"
      else
        e_formal = ""
      end
      text "<u><b>Formal</b></u>    #{c_formal}", size: 8, indent_paragraphs: 2, inline_format: :true
      text "<u><b>Levels</b></u>     #{e_formal}", size: 8, indent_paragraphs: 2, inline_format: :true
    end
  end

  def continuous_skills 
    bounding_box [@cs_orig,@total_height], width: @cs_width, height: @total_height do
      stroke_bounds
      move_down 3
      skill_header '<u>Continuous Skills</u>'
      data = [["",""]]
      @extra_data = [["",""]]
      count = 25
      @character.continuous_skills.sort.each do |s|
        count -= 1
        sk = CharacterSkill.find_by_character_id_and_skill_id(@character.id,Skill.find_by_name(s).id)
        val = sk.amount || sk.bought
        val = 0 if val == false; val = 1 if val == true
        if count > 0
          data << [s,val]
        else
          @extra_data << [s,val]
        end
      end
      move_up 12.5
      skill_table data
    end
  end

  def craftsman_skills 
    bounding_box [@cf_orig,@total_height], width: @cf_width, height: @total_height do
      stroke_bounds
      extra_continuous_skills
      move_down 3
      skill_header '<u>Craftsman Skills</u>'
      data = [["",""]]
      sk = CharacterSkill.find_by_character_id_and_skill_id(@character.id, Skill.find_by_name('Craftsman').id)
      if sk
        data << ["Craftsman <type>",sk.amount]
      else 
        sk = CharacterSkill.new(amount: 0)
      end
      move_down 2.15.in
      text "Total Craftsman #{sk.amount}", 
          size: 8,
          indent_paragraphs: 0.75.in
      move_up 2.45.in
      skill_table data
    end
  end

  def life_tag
    bounding_box [@lt_orig,@total_height], width: @lt_width, height: @total_height do
      stroke_bounds
      move_down 0.25.in
      text @chapter.location, size: 9, style: :bold, align: :center
      info_block
      move_down 0.15.in
      text "Alive", size: 16, style: :bold, align: :center
      text "1 Body Point", size: 10, align: :center
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
      data = [["","1","2","3","4","5","6","7","8","9"], celestial, earth]
      table(data) do
        cells.align = :center
        cells.size = 9
        cells.padding = 1
        rows(0).padding_bottom = 2
        rows(1..2).columns(1..9).width = 13.5
        rows(0..2).columns(1..9).align = :center
        column(0).padding_left = 0.225.in
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
      text "Total Wand Charges: #{total_c_spells},     Wand Damage: #{wand_dmg}",
          size: 8,
          indent_paragraphs: 5
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
        columns(0).padding_left = 0.35.in
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
      text @character.name, size: 10, indent_paragraphs: 5, inline_format: :true
      body_boxes
      move_down 4
      text "#{Race.find(@character.race_id).name}",
          size: 10,
          indent_paragraphs: 5,
          inline_format: :true
      move_down 1
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
      text "<b>Base Body</b> #{@character.body_points}   <b>E.Bounty</b> 0   <b>Body</b> #{@character.body_points}",
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
      text @chapter.name, size: 15, style: :bold, align: :center
    end
  end

  def skill_header label
    text "#{label}", size: 9, style: :bold_italic, inline_format: :true, indent_paragraphs: 3
  end

  def skill_table data
    table(data) do
      rows(0..30).borders = []
      columns(0).width = 1.6.in
      cells.size = 9
      cells.align = :left
      cells.height = 10
      cells.padding = 0
      cells.padding_left = 3
    end
  end

  def racial_box
    bounding_box [0,@total_height], width: @rpds_width, height: 0.655.in do
      stroke_bounds
      move_down 3
      skill_header '<u>Racial Skills</u>'
      data = [["",""]]
      CharacterSkill.all_racials(@character).each do |s|
        sk = CharacterSkill.find_by_character_id_and_skill_id(@character.id,Skill.find_by_name(s).id)
        val = sk.amount || sk.bought
        val = 0 if val == false; val = 1 if val == true
        data << [s,val]
      end
      move_up 1.5
      skill_table data
    end
  end

  def per_day_box
    bounding_box [0,@total_height], width: @rpds_width, height: 3.15.in do
      stroke_bounds
      move_down 0.68.in
      skill_header '<u>Per Day Skills</u>'
      data = [["",""]]
      @character.per_day_skills.sort.each do |s|
        sk = CharacterSkill.find_by_character_id_and_skill_id(@character.id,Skill.find_by_name(s).id)
        val = sk.amount || sk.bought
        val = 0 if val == false; val = 1 if val == true
        data << [s,val]
      end
      move_up 12.5
      skill_table data
    end
  end

  def extra_continuous_skills
    bounding_box [0,@total_height], width: @cf_width, height: 0.95.in do
      stroke_bounds
      move_down 3
      skill_header 'Continuous Skills Cont.'
      move_up 12.5
      skill_table @extra_data
    end
  end

  def info_block
    bounding_box [0,@total_height-0.4.in], width: @lt_width, height: 2.5.in do
      stroke_bounds
      move_down 0.1.in
      text @member.id.to_s, size: 9, align: :center
      text @user.first_name, size: 9, align: :center
      text @user.last_name, size: 9, align: :center
      move_down 0.15.in
      text "<u>Character</u>", size: 11, align: :center, style: :bold, inline_format: :true
      text @character.name, size: 9, align: :center
      move_down 0.75.in
      text "Home Chapter", size: 8, align: :center, style: :bold
      text Chapter.find(@character.home_chapter).name, size: 8, align: :center
      move_down 0.125.in
      text "<b>BP:</b>            #{@character.build_points}", size: 9, align: :center, inline_format: :true
      move_down 0.045.in
      text Time.now.to_date.to_s, size: 9, align: :center
    end
  end
end