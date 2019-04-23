require "test_helper"

describe WorksController do
  describe "index" do 
    it "will show index page successfully" do
      get works_path

      must_respond_with :ok
    end
  end

  describe "new" do 
    it "can render new form for Work media" do 
    end
  end

  describe "create" do 
    it "can successfully create and save a new media record" do 
    end
  end

  describe "show" do 
    it "can successfully show a work's page" do 
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
