class Ability
  include CanCan::Ability

  def initialize(user)
    #debugger
    assignments = user.assignments
    if assignments.any? { |a| a.role.name == 'Admin' }
      can :manage, :all
    else # Player user and all other users
      can [:read, :update], User do |this_user|
        this_user.id == user.id
      end
      can [:read, :xp_track], [Character, Attendee] do |this|
        this.user_id == user.id
      end
      can [:view_goblins, :events_for_chapter], Chapter
      can :create, Member
    end

    # player

    # chapter
    # can view all characters
    # can edit all 'homed' characters
    # can create/modify events
    # can create 'player' users

    # owner
    # can view other chapters
    # can create 'chapter' users

    # national
    # can view all players, characters, chapters, events

    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
