namespace :user do

    task :populate => :environment do
      puts "Importing All Members"
      load("#{Rails.root}/script/csv_import.rb")
    end
  
end