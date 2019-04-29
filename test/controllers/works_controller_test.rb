require "test_helper"

describe WorksController do
  before do
    @work = Work.create!(
      category: "test work", 
      title: 'title', 
      creator: 'Someone', 
      publication_year: 2016, 
      description: 'About a book', 
      number_of_votes: '5'
    )
  end
  describe "index" do
    it "renders without crashing" do
      get works_path

      must_respond_with :ok
    end

    it "renders even if there are zero works" do
      Work.destroy_all

      get works_path

      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the work doesn't exist" do
      work_id = 12345

      get work_path(work_id)

      must_respond_with :not_found
    end

    it "works for a work that exists" do
      get work_path(@work.id)

      must_respond_with :ok
    end
  end

  describe "new" do
    it "returns status code 200" do
      get new_work_path
      must_redirect_to login_path
    end
  end

  describe "create" do
    it "creates a new work" do
      work_data = {
        work: {
          category: 'album',
          title: "Create a new work",
          creator: 'some person',
          publication_year: 2018,
          description: 'Some details about a work',
          votes: 2
        },
      }

      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1

      must_respond_with :redirect
      must_redirect_to works_path

      work = Work.last
      expect(work.title).must_equal work_data[:work][:title]
    end

    it "sends back bad_request if no work data is sent" do
      work_data = {
        work: {
          category: "",
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
    it "responds with OK for a real work" do
      get edit_work_path(@work)
      must_respond_with :ok
    end

    it "responds with NOT FOUND for a fake work" do
      work_id = Work.last.id + 1
      get edit_work_path(work_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:work_data) {
      {
        work: {
          category: "album",
        },
      }
    }
    it "changes the data on the model" do
      @work.assign_attributes(work_data[:work])
      expect(@work).must_be :valid?
      @work.reload

      patch work_path(@work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(@work)

      @work.reload
      expect(@work.category).must_equal(work_data[:work][:category])
    end

    it "responds with NOT FOUND for a fake work" do
      work_id = Work.last.id + 1
      patch work_path(work_id), params: work_data
      must_respond_with :not_found
    end

    it "responds with BAD REQUEST for bad data" do
      work_data[:work][:title] = ""

      # puts work_data
      @work.assign_attributes(work_data[:work])
      expect(@work).wont_be :valid?
      @work.reload

      patch work_path(@work), params: work_data

      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "destroy" do
    it "removes the work from the database" do
      expect {
        delete work_path(@work)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path

      after_work = Work.find_by(id: @work.id)
      expect(after_work).must_be_nil
    end

    it "returns a 404 if the work does not exist" do
      work_id = 123456

      expect(Work.find_by(id: work_id)).must_be_nil

      expect {
        delete work_path(work_id)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end

  describe 'upvote' do
    it 'Allows you to vote for your work' do

    end

    it 'Wont let you vote for the same work more than once' do
      
    end

    it 'You must be logged in to vote' do
      
    end


  end
end
