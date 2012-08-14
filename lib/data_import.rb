require 'csv'

module DataImport
  def self.parse_csv csv_string
    csv = CSV.parse csv_string
    puts "number of lines in the file #{csv.size}" unless Rails.env = 'test'
    headers = csv.shift.map {|i| i.to_s.to_sym }
    cells = csv.map {|row| row.map {|cell| cell.to_s.strip } }
    data = cells.map {|row| Hash[*headers.zip(row).flatten] }
  end

  def self.user_import filename
    data = nil
    csv = File.read filename
    data = parse_csv csv
  end

  def self.character_import filename
    data = nil
    csv = File.open filename, "r:ISO-8859-1"
    data = parse_csv csv
  end
end