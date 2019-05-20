require "test_helper"

describe WorksController do
  describe "works#index" do
    it "should get index" do
      get works_path
      must_respond_with :success
    end
  end

  let(:work) { works(:one) }
  describe "works#show" do
    it "should get show with valid id" do
      get work_path(work.id)
      must_respond_with :success
    end

    it "should return a 404 with invalid id" do
      invalid_id = -1
      get work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  it "should get new" do
    get new_work_path
    must_respond_with :success
  end

  it "should get create given required params" do
    work_param = { work: { title: "new work",
                           category: "book" } }
    expect {
      post works_path, params: work_param
    }.must_change "Work.count", 1

    work = Work.last

    must_respond_with :redirect
    must_redirect_to work_path(work.id)
    expect(flash[:success]).must_equal "Successfully created #{work.category} #{work.id}"
    expect(work.title).must_equal work_param[:work][:title]
    expect(work.category).must_equal work_param[:work][:category]
  end

  it "should return bad request if missing category" do
    work_param = { work: { title: "new work",
                           category: nil } }
    expect {
      post works_path, params: work_param
    }.must_change "Work.count", 0
    must_respond_with :bad_request
    expect(flash[:category]).must_equal ["can't be blank"]
  end

  it "should return bad request if missing title" do
    work_param = { work: { title: nil,
                           category: "books" } }
    expect {
      post works_path, params: work_param
    }.must_change "Work.count", 0
    must_respond_with :bad_request
    expect(flash[:title]).must_equal ["can't be blank"]
  end

  it "should return bad request,send flash, and render new if not given unique title params" do
    work_param = { work: { title: work.title,
                           category: "book" } }
    expect {
      post works_path, params: work_param
    }.must_change "Work.count", 0

    must_respond_with :bad_request
    expect(flash[:title]).must_equal ["has already been taken"]
  end

  describe "works#edit" do
    it "will get to edit page if valid id" do
      id = work.id
      get edit_work_path(id)
      must_respond_with :success
    end

    it "should return a 404 with invalid id" do
      invalid_id = -1
      get edit_work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "works#update" do
    it "will update work with valid params" do
      work_param = { work: { title: "new work",
                           category: "book",
                           id: work.id } }
      expect {
        post works_path, params: work_param
      }.must_change "Work.count", 1

      work = Work.last

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
      expect(flash[:success]).must_equal "Successfully created #{work.category} #{work.id}"
      expect(work.title).must_equal work_param[:work][:title]
      expect(work.category).must_equal work_param[:work][:category]
    end

    it "should return bad request if missing category" do
      work_param = { work: { title: "new work",
                           category: nil,
                           id: work.id } }
      expect {
        post works_path, params: work_param
      }.must_change "Work.count", 0
      must_respond_with :bad_request
      expect(flash[:category]).must_equal ["can't be blank"]
    end

    it "should return bad request if missing title" do
      work_param = { work: { title: nil,
                           category: "books",
                           id: work.id } }
      expect {
        post works_path, params: work_param
      }.must_change "Work.count", 0
      must_respond_with :bad_request
      expect(flash[:title]).must_equal ["can't be blank"]
    end

    it "should return bad request,send flash, and render new if not given unique title params" do
      work_param = { work: { title: work.title,
                           category: "book",
                           id: work.id } }
      expect {
        post works_path, params: work_param
      }.must_change "Work.count", 0

      must_respond_with :bad_request
      expect(flash[:title]).must_equal ["has already been taken"]
    end
  end

  describe "works#destroy" do
    it "will destroy a valid id" do
      id = work.id
      expect {
        delete work_path(id)
      }.must_change "Work.count", -1
      must_respond_with :redirect
      must_redirect_to root_path
      expect(flash[:success]).must_equal "Successfully destroyed #{work.category} #{work.id}"
    end

    it "should return a 404 with invalid id" do
      invalid_id = -1
      expect {
        delete work_path(invalid_id)
      }.wont_change "Work.count"
      must_respond_with :not_found
    end
  end
end
