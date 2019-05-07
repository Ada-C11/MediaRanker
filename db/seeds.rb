require 'csv'

input_users = [
  {
    username: "test",
  },
]

users_failures = []
input_users.each do |input_user|
  user = User.new(username: input_user[:username])
  successful = user.save
  if successful
    puts "Created user: #{user.inspect}"
  else
    users_failures << user
    puts "Failed to save user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{users_failures.length} users failed to save"


WORKS_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw work data from #{WORKS_FILE}"

works_failures = []
CSV.foreach(WORKS_FILE, :headers => true) do |row|
  Work.create!(category: row['category'], title: row['title'], creator: row['creator'], publication_year: row['publication_year'], description: row['description'], user_id: 1  )
  # work = Work.new
  # work.category = row['category']
  # work.title = row['title']
  # work.creator = row['creator']
  # work.publication_year = row['publication_year']
  # work.description = row['description']
  # successful = work.save
  # if !successful
  #   works_failures << work
  #   puts "Failed to save work: #{work.inspect}"
  # else
  #   puts "Created work: #{work.inspect}"
  # end
end

puts "Added #{Work.count} work records"
puts "#{works_failures.length} works failed to save"

