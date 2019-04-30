require "faker"
require "date"
require "csv"

# we already provide a filled out media_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new media_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open("db/media_seeds.csv", "w", :write_headers => true,
                                    :headers => ["category", "title", "creator", "publication_year", "description"]) do |csv|
  100.times do
    category = %w(album movie book).sample
    title = Faker::Hacker.adjective.capitalize + " " + Faker::ElectricalComponents.electromechanical
    creator = Faker::Superhero.name
    publication_year = rand(Date.today.year - 100..Date.today.year)
    description = Faker::Company.catch_phrase + Faker::Company.bs

    csv << [category, title, creator, publication_year, description]
  end
end
