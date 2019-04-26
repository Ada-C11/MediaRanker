require "test_helper"

describe HomepagesController do
  describe "index" do
    it "should get index" do
      get homepages_index_path
      must_respond_with :success
    end

    it "should get index even if there are no works" do
      Work.all.each do |work|
        work.votes.each { |vote| vote.destroy }
        work.destroy
      end
      get homepages_index_path
      must_respond_with :success
    end
  end

  # WAVE 1 TESTING: DOES THE MAIN PAGE LOAD IF THERE ARE NO WORKS? how do you test that?
end
