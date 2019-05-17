require "test_helper"

describe WorksController do
  let(:work) { works(:book) }
  let(:work_2) { works(:album_1) }

  describe "index action" do
    it "will show works index page" do
      get works_path

      must_respond_with :success
      
    end

    it "will render regardless of having no media" do
      Work.destroy_all

      get works_path

      must_respond_with :success
      
    end
  end

  describe "new action" do
    it "renders form to add new work" do
      get new_work_path

      must_respond_with :success
    end

  end

  describe "show action" do
    it "shows a details page for an existing work" do 
      get work_path(work.id)

      must_respond_with :success
    end

    it "redirects if given invalid id" do
      get work_path(-1)

      must_respond_with :redirect
      must_redirect_to root_path
      expect(flash[:failure]).must_equal "Your search returned no results."
    end
  end

  describe "new" do
    it "gets to the new page" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create action" do
    it "successfully creates a new media" do 
      work_params = {
        "work": {
          category: "book",
          title: "1984",
          creator: "George Orwell",
          pub_year: 1948,
          description: "A startling and haunting vision of the world, 1984 is so powerful that it is completely convincing from start to finish"
        }
      }

      expect {
        post works_path, params: work_params
      }.must_change "Work.count", 1

      must_respond_with :redirect
      new_media = Work.find_by(title: work_params[:work][:title])
      expect(flash[:success]).must_equal  "#{new_media.title} was successfully created."
      must_redirect_to work_path(new_media.id)
    end

    it "will give a 404 for bad parameters" do
      work_params = {
        "work": {
          category: "book",
          title: "",
          creator: "George Orwell",
          pub_year: 1948,
          description: "A startling and haunting vision of the world, 1984 is so powerful that it is completely convincing from start to finish"
        }
      }

      expect {
        post works_path, params: work_params
      }.wont_change "Work.count" 

      must_respond_with :bad_request
    end


    describe "edit action" do
      it "can edit existing media" do
        get edit_work_path(work.id)

        must_respond_with :success
      end

      it "will return 404 for invalid work id" do
        get edit_work_path(-1)

        must_respond_with :not_found
      end
    end

    describe "update action" do
      it "can update an existing work" do

        update_params = {
          work: {
            category: "album",
            title: "Electric Gypsy",
            creator: "Andy Timmons",
            publication_year: 1994,
            description: "All the college feels.",
          },
        }

        expect {
          patch work_path(work_2.id), params: update_params
        }.wont_change "Work.count"

        must_respond_with :redirect
        work_2.reload
        expect(flash[:success]).must_equal "Successfully updated #{work_2.title}"
      end

      # it "returns 404 for invalid  work" do
      #   work_2

      #   work_id = Work.last.id + 1
      #   patch work_path(work_id), params: update_params

      #   must_respond_with :not_found
      # end
    end

    describe "destroy action" do
      it "can delete a work" do
        expect {
          delete work_path(work.id)
        }.must_change "Work.count", -1
  
        must_respond_with :redirect
        must_redirect_to works_path
        expect(flash[:success]).must_equal  "Success! #{work.title} is now deleted."
      end

      it "redirects to thee root path for invalid work" do
        expect {
          delete work_path(-1)
        }.wont_change "Work.count"
  
        must_respond_with :redirect
        must_redirect_to root_path
        expect(flash[:failure]).must_equal "Unable to delete the specified media."
      end
    end
  end
end
