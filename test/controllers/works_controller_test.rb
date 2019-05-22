require "test_helper"

describe WorksController do
  describe "index" do
    it "can get index" do
      get works_path
      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "shows a work that exists" do
      get work_path(works(:summer).id)
      must_respond_with :ok
    end

    it "returns a 404 status code if the work doesn't exist" do
      get work_path(-1)
      must_respond_with :not_found
    end

  end

  describe "new" do
    it "can get to new work path" do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates a new work" do
      work_data = {
        work: {
          category: "book",
          title: "This is how you lose her",
          creator: "junot diaz",
          publication_year: 2012,
          description: "test"
        }
      }

      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1

      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "doesn't create new work with data that is invalid" do
      work_data = {
        work: {
          title: "",
        },
      }

      expect(Work.new(work_data[:work])).wont_be :valid?

      expect {
        post works_path, params: work_data
      }.wont_change "Work.count"

    end



  end 

  describe "edit" do
    it "responds with OK for a real work" do
      get edit_work_path(works(:call))
      must_respond_with :ok
    end

    it "responds with not found for non existent work" do
      get edit_work_path(-1)
      must_respond_with :not_found
    end

  end

  describe "update" do
    it "changes the data on the model" do
      work_data = {
        work: {
          category: "movie"
        }
      }

      patch work_path(works(:call)), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(works(:call))

      works(:call).reload
      expect(works(:call).category).must_equal(work_data[:work][:category])

    end

    it "does not update for bad input data" do
      work_data = {
        work: {
          category: ""
        }
      }

      patch work_path(works(:call)), params: work_data
      must_respond_with :redirect
    end


  end

  describe "destroy" do
    it "removes the work from the database" do
  
      expect {
        delete work_path(works(:testing))
      }.must_change "Work.count", -1

      
      must_respond_with :redirect
      must_redirect_to works_path

      deleted_work = Work.find_by(id: works(:testing).id)
      expect(deleted_work).must_be_nil
    end

    it "returns a 404 if the book does not exist" do
  
      expect(Work.find_by(id: -1)).must_be_nil
      expect {
        delete work_path(-1)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end



end
