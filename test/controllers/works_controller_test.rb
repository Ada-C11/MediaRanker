require "test_helper"

describe WorksController do

  describe "DriversController" do
    
    describe "index" do
      it "can get index" do
        get works_path
  
        must_respond_with :success
      end

      it "renders even if there are no works" do
        # Arrange
        Work.destroy_all
  
        # Act
        get works_path
  
        # Assert
        must_respond_with :success
      end
    end
  
    describe "show" do
      it "can get a valid work" do
      goldfinch = Work.find_by(title: "The Goldfinch")
        get work_path(goldfinch.id)
  
        # Assert
        must_respond_with :success
      end
  
      it "will redirect for an invalid driver" do
        # Act
        get work_path(-1)
  
        # Assert
        must_respond_with :not_found
      end
    end

    describe "edit" do
      it "can get the edit page for an existing work" do
        # Act
        goldfinch = Work.find_by(creator: "Donna Tartt")
  
        get edit_work_path(goldfinch.id)
  
        # Assert
        must_respond_with :success
      end
  
      it "will respond with redirect when attempting to edit a nonexistant work" do
        get edit_work_path(999)
  
        must_respond_with :not_found
      end
    end
  
    describe "update" do
      let(:work_data) {
        {
          work: {
            category: "book",
            title: "test title"
          },
        }
      }
      it "can update an existing work" do
        user = User.create(username: "Test")
       idaho = Work.create(category: "movie", title: "My Own Private Idaho", user_id: user.id)
  
        # Act-Assert
        patch work_path(idaho), params: work_data

        # Assert
        must_respond_with :redirect
        must_redirect_to work_path(idaho)

        check_flash

        idaho.reload
        expect(idaho.title).must_equal(work_data[:work][:title])
      end
  
      it "will redirect to the root page if given an invalid id" do
        patch work_path(99), params: work_data
        must_respond_with :not_found
      end

      it "will respond with bad request for bad parameters" do
        idaho = Work.find_by(creator: "Gus Van Sant")
        # Arrange
        work_data[:work][:title] = ""
  
        # Assumptions
        idaho.assign_attributes(work_data[:work])
        expect(idaho).wont_be :valid?
        idaho.reload
  
        # Act
        patch work_path(idaho), params: work_data
  
        # Assert
        must_respond_with :bad_request
  
        check_flash(:error)
      end
    end
  
    describe "new" do
      it "can get the new work page" do
  
        get new_work_path
  
        must_respond_with :success
      end
    end
  
    describe "create" do
      it "can create a new work" do
        post login_path, params: {
          user: {
            username: "test",
          },
        }
        work_data = {
          work: {
            category: "album",
            title: "Lines, Vines and Trying Times",
            creator: "Jonas Brothers",
            user_id: session[:user_id]
          },
        }
        #  user.id = session[:user_id]
        # Act-Assert
        expect {
          post works_path, params: work_data
        }.must_change "Work.count", +1
  
        work = Work.last
        must_respond_with :redirect
        must_redirect_to work_path(work.id)

        check_flash

        expect(work.title).must_equal work_data[:work][:title]
      end

      it "returns bad request if no data is sent" do
        work_data = {
          work: {
            title: "",
          },
        }
        expect(Work.new(work_data[:work])).wont_be :valid?
  
        # Act
        expect {
          post works_path, params: work_data
        }.wont_change "Work.count"
  
        # Assert
        must_respond_with :bad_request
  
        check_flash(:error)
      end
    end
  
    describe "destroy" do
      it "removes the work from the database" do
        user = User.create(username: "Test")
        work = Work.create(category: "movie", title: "My Own Private Idaho", user_id: user.id)
        
        expect {
          delete work_path(work)
        }.must_change "Work.count", -1

        must_respond_with :redirect
        must_redirect_to works_path

        check_flash

        after_work = Work.find_by(id: work.id)
        expect(after_work).must_be_nil
      end
  
      it "returns a 404 if the work does not exist" do
        work_id = 999
  
        expect(Work.find_by(id: work_id)).must_be_nil
  
        expect {
          delete work_path(work_id)
        }.wont_change "Work.count"
  
        must_respond_with :not_found
      end
    end
  end
end
