require "csv"

SEEDS = Rails.root.join("db", "media_seeds.csv")

seed_fails = []

CSV.foreach(SEEDS, :headers => true) do |seed|
  work = Work.new
  work.category = seed["category"]
  work.title = seed["title"]
  work.creator = seed["creator"]
  work.publication_year = seed["publication_year"].to_i
  work.description = seed["description"]

  success = work.save
  if !success
    seed_fails << work
    puts "Failed to save: #{work.inspect}"
  end
end

puts "#{seed_fails.length} failed to save."
