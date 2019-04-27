require "test_helper"

describe WorksController do
  it "get works index page" do
    get works_path
    must_respond_with :success
  end

  describe "new" do
    it "get new work page" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "save a new work and redirect if given valid inputs" do

      # Arrange
      new_work_title = "Star Wars: A New Hope"
      new_work_creator = "George Lucas"
      new_work_description = "A young Luke Skywalker is torn from his childhood home at the mysterious appearance of two robots and a wizened sorcerer, one of whom holds the secret to defeating an intergalactic empire."
      new_work_pub = "1977"

      valid_work_params = {
        work: {
          title: new_work_title,
          creator: new_work_creator,
          description: new_work_description,
          publication_year: new_work_pub,
          category: "movie",
        },
      }

      # Act
      expect {
        post works_path, params: valid_work_params
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: new_work_title)
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal new_work_title
      expect(new_work.description).must_equal new_work_description

      must_respond_with :redirect
    end

    it "return 404 bad request for an invalid work" do
      bad_work_title = ""
      bad_work_description = "bad description, not very descriptive"
      bad_work_params = {
        work: {
          title: bad_work_title,
          description: bad_work_description,
          category: "movie",
        },
      }

      expect {
        post works_path, params: bad_work_params
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "show" do
    it "display a valid work" do
      valid_work_id = works(:readyplayerone).id
      get works_path(valid_work_id)
      must_respond_with :success
    end

    it "return a 404 not found when searching for a non-existant work" do
      get work_path(-1)
      must_redirect_to works_path
    end
  end

  # describe "edit" do
  #   it "get the edit page for a work" do
  #     get edit_work_path(work.id)
  #     must_respond_with :success
  #   end

  #   it "respond with 404 not found when loading the edit page for a nonexistant work" do
  #     get edit_work_path(-1)
  #     must_respond_with :not_found
  #   end
  # end

  # describe "update" do
  #   new_params = {
  #     work: {
  #       name: "Terry Turtle",
  #       phone_num: "555-1212",
  #     },
  #   }

  #   it "update an existing work" do
  #     work_to_update = Work.create!(
  #       name: "Fredrica Fishes",
  #       phone_num: "+42 857-757-5736",
  #     )
  #     expect {
  #       patch work_path(work_to_update.id), params: new_params
  #     }.wont_change "Work.count"

  #     work_to_update.reload
  #     expect(work_to_update.name).must_equal new_params[:work][:name]
  #     expect(work_to_update.phone_num).must_equal new_params[:work][:phone_num]
  #   end

  #   it "respond with 404 not found if updating a non-existant work" do
  #     # edge case: it should render a 404 if the work is not found
  #     # THIS TEST IS GIVING AN ERROR. WHY? It's trying to call .update on a nil object. Line 22 of controller should catch this.

  #     skip
  #     expect {
  #       patch work_path(-1), params: new_params
  #     }.wont_change "Work.count"

  #     must_respond_with :not_found
  #   end

  #   it "return a 400 bad_request when asked to update with invalid data" do

  #     # Arrange
  #     original_work = {
  #       name: "Katniss",
  #       phone_num: "RU43U3R4U",
  #     }

  #     work_to_update = Work.create(original_work)

  #     new_work_name = "" # invalid name
  #     new_work_phone = "54321"

  #     bad_params = {
  #       "work": {
  #         name: new_work_name,
  #         phone_num: new_work_phone,
  #       },
  #     }

  #     # Act
  #     expect {
  #       patch work_path(work_to_update.id), params: bad_params
  #     }.wont_change "Work.count"

  #     # Assert
  #     must_respond_with :bad_request
  #     work_to_update.reload
  #     expect(work_to_update.name).must_equal original_work[:name]
  #     expect(work_to_update.phone_num).must_equal original_work[:phone_num]
  #   end
  # end

  # describe "destroy" do
  #   it "delete a work" do
  #     new_work = Work.create(name: "Fuzzy Bunny", phone_num: "99955545")

  #     expect {
  #       delete work_path(new_work.id)
  #     }.must_change "Work.count", -1

  #     must_respond_with :redirect
  #     must_redirect_to works_path
  #   end

  #   it "return a 404 not found error if the work is not found" do
  #     invalid_id = -1

  #     expect {
  #       delete work_path(invalid_id)
  #     }.wont_change "Work.count"
  #     must_respond_with :not_found
  #   end
  # end
end
