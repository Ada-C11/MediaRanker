User.all.each do |user|
  votes = [*1..23]
  13.times do |i|
    work_id = votes.shuffle!.pop
    Vote.create(user_id: user.id, work_id: work_id)
  end
end

vote_hash = Hash.new(0)
Vote.all.each do |vote|
  vote_hash[vote.work_id] += 1
end

work_hash = Hash.new(0)
works.each do |vote|
  work_hash[vote.id] = vote.vote_ids.count
end

20.times do |i|
  User.create(username: "somename#{i}")
end

100.times do |i|
  user_id = rand(50)
  votes = [*1..23]
  13.times do |i|
    work_id = votes.shuffle!.pop
    Vote.create(user_id: user_id, work_id: work_id)
  end
end

200.times do
  id = (rand(379))
  vote = Vote.find_by(id: id)
  vote.destroy if vote
end

5.times do |i|
  Work.create(title: "#{i}qweasdzxc", category: "movie")
end
