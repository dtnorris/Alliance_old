include DataImport

Time.zone = 'Eastern Time (US & Canada)'

chapters = [
  { name: 'Southern Minnesota', owner: 'David Glaiser', email: 'dg@test.com', location: 'soMN' },
  { name: 'Caldaria', owner: 'Jessey Hennessey', email: 'jh@test.com', location: 'CT' }
]

chapters.each do |c|
  char_data = DataImport.character_import(c[:location])

  puts "Importing Characters for: #{c[:location]}"
  Character.data_import(char_data, c[:location])
end


puts "IMPORT SUCCESS!"