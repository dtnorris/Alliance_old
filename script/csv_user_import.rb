include DataImport

Time.zone = 'Eastern Time (US & Canada)'

chapters = [
  { name: 'Southern Minnesota', owner: 'David Glaiser', email: 'dg@test.com', location: 'soMN' },
  { name: 'Caldaria', owner: 'Jessey Hennessey', email: 'jh@test.com', location: 'CT' }
]

chapters.each do |c|
  user_data = DataImport.user_import("#{Rails.root}/data/#{c[:location]}/Members_#{c[:location]}.csv")

  puts "Creating Chapter: #{c[:location]}"
  Chapter.data_import(c)
  puts "Importing Users and creating Memberships for: #{c[:location]}"
  User.data_import(user_data, c[:location])
end


puts "IMPORT SUCCESS!"