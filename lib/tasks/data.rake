namespace :import do

    task :users => :environment do
      puts "Importing All Members and Characters"
      load("#{Rails.root}/script/csv_user_import.rb")
    end

    task :characters => :environment do
      #puts "Deleting all Existing Characters"
      #Character.delete_all

      puts "Importing All Characters"
      load("#{Rails.root}/script/csv_character_import.rb")
    end
  
end