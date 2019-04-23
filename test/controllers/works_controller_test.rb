require "test_helper"

describe WorksController do
  describe "index" do
    it "can get to the root path" do
      get root_path

      must_respond_with :success
    end

    it "can get to the index path" do
      get works_path

      must_respond_with :success
    end
  end
  describe "show" do
    it "can get a valid work" do
      work = works(:one)

      get work_path(work.id)

      must_respond_with :success
    end

    it "will redirect for an invalid work" do
      get work_path(-1)

      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new work page" do
      get new_work_path

      must_respond_with :success
    end
  end

  # describe "create" do

  #   it "can create a new work" do
  #     work_hash = {
  #       title: "New work",
  #       creator: "Creator",
  #       description: "new work description",
  #       production_year: 2000,
  #     }
  #     expect {
  #       post works_path, params: work_hash
  #     }.must_change "Work.count", 1

  #     new_work = Work.find_by(title: work_hash[:title])
  #     expect(new_work.description).must_equal work_hash[:description]
  #     expect(new_work.creator).must_equal work_hash[:creator]

  #     must_respond_with :redirect
  #     must_redirect_to work_path(new_work.id)
  #   end
  # end

  describe "edit" do
  end
end
