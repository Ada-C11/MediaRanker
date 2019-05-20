# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

failed_to_save = []
CSV.open("db/media_seeds.csv", headers: true).each_with_index do |line, i|
  media = Work.new(category: line["category"],
                   title: line["title"],
                   creator: line["creator"],
                   publication_year: line["publication_year"],
                   description: line["description"])
  if media.save
    puts "#{i + 1} #{media} successfully saved"
  else
    failed_to_save << media
  end
end

puts "#{failed_to_save.count} FAILED TO SAVE"
