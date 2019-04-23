require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'media_seeds.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Work.new
  t.category = row['category']
  t.title = row['title']
  t.creator = row['creator']
  t.publication_year = row['publication_year']
  t.description = row['description']
  t.save
end