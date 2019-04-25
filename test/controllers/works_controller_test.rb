require "test_helper"

describe WorksController do
  require "test_helper"

  describe "DriversController" do
    
    describe "index" do
      it "can get index" do
        get works_path
  
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
        must_respond_with :redirect
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
  
        must_respond_with :redirect
        must_redirect_to works_path
      end
    end
  
    describe "update" do
      it "can update an existing work" do
       idaho = Work.find_by(creator: "Gus Van Sant")
        
        work_hash = {
          work: {
            category: "movie",
            title: "Drugstore Cowboy",
            creator: "Gus Van Sant",
            publication_year: 1989,
            description: "Matt Dillon as a drug addict"
          },
        }
  
        # Act-Assert
        expect {
          patch work_path(idaho.id), params: work_hash
        }.must_change "Work.count", 0
  
        expect(idaho.title).must_equal "My Own Private Idaho"
        #Repulling from database - updating the title variable
        idaho.reload
        expect(idaho.category).must_equal work_hash[:work][:category]
        expect(idaho.title).must_equal work_hash[:work][:title]
        expect(idaho.creator).must_equal work_hash[:work][:creator]
        expect(idaho.publication_year).must_equal work_hash[:work][:publication_year]
        expect(idaho.description).must_equal work_hash[:work][:description]

  
        must_respond_with :redirect
        must_redirect_to work_path(idaho.id)
      end
  
      it "will redirect to the root page if given an invalid id" do
          patch work_path(999)
          must_respond_with :redirect
          must_redirect_to works_path
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
        zeds_dead = Work.find_by(title: "Somewhere Else")
        work_hash = {
          work: {
            category: zeds_dead.category,
            title: zeds_dead.title,
            creator: zeds_dead.creator,
          },
        }
  
        # Act-Assert
        expect {
          post works_path, params: work_hash
        }.must_change "Work.count", 1
  
        new_work = Work.find_by(title: work_hash[:work][:title])
        expect(new_work.category).must_equal work_hash[:work][:category]
        expect(new_work.creator).must_equal work_hash[:work][:creator]
        
        must_respond_with :redirect
        must_redirect_to work_path(new_work.id)
      end
    end
  
    describe "destroy" do
      it "removes the work from the database" do
        work = Work.create(category: "movie", title: "My Own Private Idaho")
        
        expect {
          delete work_path(work)
        }.must_change "Work.count", -1
  
        must_respond_with :redirect
        must_redirect_to works_path
  
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
