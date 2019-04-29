# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

works = [
  {category: "album", title: "Day & Age", created_by: "The Killers", published: "2008", description: "Best album ever."}, 
  {category: "album", title: "LSD", created_by: "Labrinth, Sia & Diplo", published: "2019", description: "Second best album ever."}, 
  {category: "book", title: "If You Meet the Buddha on the Road, Kill Him", created_by: "Sheldon B. Kopp", published: "1972", description: "Free yourself!"},
  {category: "book", title: "The Power of Starting Something Stupid", created_by: "Richie Norton", published: "2012", description: "Free yourself even more!"},
  {category: "movie", title: "Pan's Labyrinth", created_by: "Guillermo del Toro", published: "2006", description: "Scare your socks off and feel emotions while that happens."},
  {category: "movie", title: "The Ring", created_by: "Gore Verbinski", published: "2002", description: "Scare your socks off!"}
]

works.each do |work|
  Work.create(work)
end

users = [
  {username: "username"}, 
  {username: "joi"},
  {username: "lovethearts"}
]

users.each do |user|
  User.create(user)
end