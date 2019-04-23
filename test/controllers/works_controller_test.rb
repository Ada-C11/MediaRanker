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
    end
  end

  describe "update" do 
    it "can successfully update a media record" do 
    end
  end

  describe "delete" do 
    it "can successfully remove a media record" do 
    end
  end
end
