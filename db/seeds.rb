require "csv"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
MEDIA_FILE = Rails.root.join("db", "media_seeds.csv")
puts "Loading raw driver data from #{MEDIA_FILE}"
media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  media = Work.new
  media.category = row["category"]
  media.title = row["title"]
  media.creator = row["creator"]
  media.publication_year = row["publication_year"]
  media.description = row["description"]
  successful = media.save
  if !successful
    media_failures << media
    puts "Failed to save work: #{media.inspect}"
  else
    puts "Created work: #{media.inspect}"
  end
end
puts "Added #{media.count} work records"
puts "#{media_failures.length} work failed"
