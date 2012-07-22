include DataImport

Time.zone = 'Eastern Time (US & Canada)'

chapters = [
  { name: 'Gaden', owner: 'David Glaiser', email: 'dg@test.com', location: 'soMN' }
]

chapters.each do |c|
  data = DataImport.user_import(c[:location])

  puts "Creating Chapter: #{c[:location]}"
  Chapter.data_import(c)
  puts "Importing Users and created Memberships for: #{c[:location]}}"
  User.data_import(data, c[:location])
end

puts "IMPORT SUCCESS!"