require "test_helper"

describe HomepagesController do
  it "should get index" do
    get root_path

    must_respond_with :success
  end

  it "should still work without work" do
    Work.all.each do |work|
      #work.votes.each { |vote| vote.destroy }
      #I've talked to some people that say its really important to delete all corresponding votes, but I'm getting it to work without it? am I missing somthing?
      work.destroy
    end
    get root_path
    must_respond_with :success
  end
end
