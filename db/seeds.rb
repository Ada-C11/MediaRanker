require 'csv'

WORKS_FILE = Rails.root.join("db", "media_seeds.csv")
puts "Loading raw work data from #{WORKS_FILE}"

work_failures = []
CSV.foreach(WORKS_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end
