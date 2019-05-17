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
                                    :headers => ["category", "title", "creator", "pub_year", "description"]) do |csv|
  25.times do
    category = %w(album book movie).sample
    title = Faker::Coffeer.blend_name
    creator = Faker::JapaneseMedia::OnePiece.character
    pub_year = rand(Date.today.year - 100..Date.today.year)
    description = Faker::Hipster.unique.sentence

    csv << [category, title, creator, pub_year, description]
  end
end
