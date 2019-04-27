# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
require "faker"

MEDIA_FILE = Rails.root.join("db", "media_seeds.csv")
puts "Loading raw media data from #{MEDIA_FILE}"

work_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row["category"]
  work.title = row["title"]
  work.creator = row["creator"]
  work.publication_year = row["publication_year"].to_i
  work.description = row["description"]
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

user_failures = []
10.times do |i|
  user = User.new
  user.name = Faker::Name.first_name.downcase

  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

vote_failures = []
30.times do |i|
  vote = Vote.new
  vote.user = User.all.sample
  vote.work = Work.all.sample

  successful = vote.save
  if !successful
    vote_failures << vote
    puts "Failed to save vote: #{vote.inspect}"
  else
    puts "Created vote: #{vote.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"
