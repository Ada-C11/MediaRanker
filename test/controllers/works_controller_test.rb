require "test_helper"

describe WorksController do
let(:work) { Work.create!(category: "movie", title: "Into the Wild") }

  describe "index" do 
    it "will show works index page successfully" do
      get works_path

      must_respond_with :ok
    end

    it "will render even with no media" do 
      Work.destroy_all

      get works_path

      must_respond_with :ok
    end
  end

  describe "new" do 
    it "can render new form for Work media" do 
      get new_work_path

      must_respond_with :ok
    end
  end

  describe "create" do 
    it "can successfully create and save a new media record" do 
      media_params = {
        work:{
          category: "book",
          title: "The New Jim Crow",
          creator: "Michelle Alexander",
          publication_year: 2010,
          description: "Mass Incarceration in the Age of Colorblindness"
        }
      }

      expect {
        post works_path, params: media_params
      }.must_change "Work.count", +1

      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "will send 400 bad request with invalid parameters" do 
      media_params = {
        work:{
          category: "book",
          title: "",
          creator: "Michelle Alexander",
          publication_year: 2010,
          description: "Mass Incarceration in the Age of Colorblindness"
        }
      }

      expect {
        post works_path, params: media_params
      }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "show" do 
    it "can successfully show a work's page" do
      get work_path(work.id) 

      must_respond_with :ok
    end

    it "responds with 404 when work record not found" do 
      get work_path(1337)

      must_respond_with :not_found
    end
  end

  describe "edit" do 
    it "can successfully render edit media form" do 
      get edit_work_path(work.id)

      must_respond_with :ok
    end

    it "will respond with 404 not found for invalid media id" do 
      get edit_work_path(1337)

      must_respond_with :not_found
    end
  end

  describe "update" do 
    let(:edit_params) {
      {
      work:{
        publication_year: 2010,
        description: "Mass Incarceration in the Age of Colorblindness"
      }
    }
  }
    it "can successfully update a media record" do 
      work.assign_attributes(edit_params[:work])
      expect(work).must_be :valid?
      work.reload

      patch work_path(work), params: edit_params

      must_respond_with :redirect
      must_redirect_to work_path(work.id)

      work.reload
      expect(work.publication_year).must_equal edit_params[:work][:publication_year]
    end

    it "responds with 404 not found for nonexistant media" do 
      work 

      work_id = Work.last.id + 1

      patch work_path(work_id), params: edit_params

      must_respond_with :not_found
    end
  end

  describe "delete" do 
    it "can successfully remove a media record" do 
    end
  end
end
