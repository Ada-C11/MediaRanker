require "csv"

work_text = File.read(Rails.root.join("db", "media_seeds.csv"))
csv = CSV.parse(work_text, :headers => true)

work_failures = []
csv.each do |row|
  w = Work.new
  w.category = row["category"]
  w.title = row["title"]
  w.creator = row["creator"]
  w.pub_year = row["pub_year"].to_i
  w.description = row["description"]
  successful = w.save
  if !successful
    work_failures << w
    puts "Failed to save work: #{w.inspect}"
  else
    puts "#{w.title}, a #{w.category} saved"
  end
end

puts "There are now #{Work.count} works saved"
