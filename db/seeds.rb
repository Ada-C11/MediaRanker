require "csv"
require "faker"

MEDIA_FILE = Rails.root.join("db", "media_seeds.csv")

work_failures = []

CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row["category"]
  work.title = row["title"]
  work.creator = row["creator"]
  work.publication_year = row["publication_year"]
  work.description = row["description"]
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"

user_failures = []
15.times do
  user = User.new(username: Faker::Movies::PrincessBride.unique.character)
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"

vote_failures = []
User.all.each do |user|
  Work.all.each do |work|
    randomizer = rand(2)
    if randomizer == 1
      vote = Vote.new(user_id: user.id, work_id: work.id)
      successful = vote.save
      if !successful
        vote_failures << vote
        puts "Failed to save vote: #{vote.inspect}"
      else
        puts "Created vote: #{vote.inspect}"
      end
    end
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"
