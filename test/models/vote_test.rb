# require "test_helper"

# describe Vote do
#   before do
#     @user = User.create(
#       username: 'Bob',
#       number_of_votes: 1
#     )
#     @work = Work.create!(
#         category: "test work", 
#         title: 'new title', 
#         creator: 'Someone', 
#         publication_year: 2016, 
#         description: 'About a book', 
#         number_of_votes: '5'
#       )
#   end
  
#   let(:vote) { 
#     Vote.create!(user_id: @user.id, work_id: @work.id) 
#   }

#   it "must be valid" do
#     value(vote).must_be :valid?
#   end
# end
