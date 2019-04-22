# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

MEDIA_FILE = Rails.root.join("db", "media_seeds.csv")
puts "Loading raw driver data from #{MEDIA_FILE}"

media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  # work.id = row['id']
  work.title = row["title"]
  work.creator = row["creator"]
  work.category = row["category"]
  # work.publication_year = Date.new(row["publication_date"])
  work.description = row["description"]
  successful = work.save
  if !successful
    driver_failures << driver
    puts "Failed to save driver: #{work.inspect}"
  else
    puts "Created driver: #{work.inspect}"
  end
end

puts "Added #{Work.count} driver records"
puts "#{media_failures.length} works failed to save"

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
