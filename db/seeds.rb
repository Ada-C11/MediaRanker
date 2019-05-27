require "csv"

SEEDS = Rails.root.join("db", "media_seeds.csv")

seed_fails = []

CSV.foreach(SEEDS, :headers => true) do |seed|
  work = Work.new
  work.category = seed["category"]
  work.title = seed["title"]
  work.creator = seed["creator"]
  work.publication_year = seed["publication_year"]
  work.description = seed["description"]

  success = work.save
  if !success
    seed_fails << work
    puts seed_fails
  end
end

puts "#{seed_fails.length} failed to save."
