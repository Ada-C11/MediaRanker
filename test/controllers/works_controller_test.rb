require "test_helper"

describe WorksController do
  let (:work) { works(:one) }

  describe 'index' do 
    it 'can get to index path' do 
      get works_path

      must_respond_with :success
    end
  end  

  describe 'show' do 
    it 'can get to valid work path' do 
      get work_path(work.id)
      must_respond_with :success
    end

    it "will redirect with an invalid work" do
      get work_path(-1)

      must_respond_with :redirect
    end
  end

  describe "new" do 
    it "can get a new work page" do 
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do 
    it "can create a new work" do 
      work_hash = {
        work: {
          title: "test work",
          creator: "test creator",
          description: "test description",
          publication_year: 1990,
        },
      }
      
      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", +1
      
      new_work = Work.find_by(title: work_hash[:work][:title])
      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)

      check_flash

      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.description).must_equal work_hash[:work][:description]
    end

    it "sends back bad_request if no work data is sent" do
      work_data = {
        work: {
          title: "",
        },
      }
      expect(Work.new(work_data[:work])).wont_be :valid?

      expect {
        post works_path, params: work_data
      }.wont_change "Work.count"

      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "edit" do 
    it "canget the edit page for an existing work" do 
      get edit_work_path(work.id)
      must_respond_with :success
    end

    it "will respond with a redirect when attempting to edit a nonexistant path" do 
      get edit_work_path(-1)
      must_redirect_to works_path
    end
  end

  describe "update" do 
    let(:work_params) {
      {
        work: {
          title: "Enders Game",
          creator: "Homophobe",
          description: "good book, crap author",
          publication_year: "1985",
        },
      }
    }

    it "can update data on existing work" do 
      work.assign_attributes(work_params[:work])
      expect(work).must_be :valid?

      patch work_path(work), params: work_params 

      must_respond_with :redirect
      expect(work.title).must_equal(work_params[:work][:title])

      check_flash
    end

    it "responds with NOT FOUND for a fake book" do
      work_id = Work.last.id + 1
      patch work_path(work_id), params: work_params
      must_respond_with :not_found
    end

    it "responds with BAD REQUEST for bad data" do 
      work_params[:work][:title] = ""

      work.assign_attributes(work_params[:work])
      expect(work).wont_be :valid?

      patch work_path(work), params: work_params

      must_respond_with :bad_request 

      check_flash(:warning)
    end
  end

  # describe "destroy" do 
  #   it "removes work from database" do 
  #     expect {
  #       delete work_path(work)
  #     }.must_change "Work.count", -1

  #     must_respond_with :redirect
  #     must_redirect_to works_path
  #   end

  #   it "returns a 404 if the book does not exist" do 
  #     work_id = 123456

  #     expect(Work.find_by(id: work_id)).must_be_nil

  #     expect {
  #       delete work_path(work_id)
  #     }.wont_change "Work.count"
  #   end
  # end
end
