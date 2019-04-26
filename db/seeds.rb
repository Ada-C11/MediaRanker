require "csv"
# require "pry"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
input_works = CSV.read("db/media_seeds.csv", headers: true)
work_failures = []
input_works.each do |input_work|
  #binding.pry
  work = Work.new
  work.category = input_work["category"]
  work.title = input_work["title"]
  work.creator = input_work["creator"]
  work.description = input_work["description"]
  work.publication_date = input_work["publication_date"]

  successful = work.save
  if successful
    puts "Created work: #{work.inspect}"
  else
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"
