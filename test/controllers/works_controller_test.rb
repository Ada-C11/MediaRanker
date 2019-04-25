require "test_helper"

describe WorksController do
  describe "index" do
    it "should get index" do
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should get show" do
      get work_path(works(:one).id)
      must_respond_with :success
    end

    it "will redirect if invalid work" do
      get work_path(-1)

      must_redirect_to works_path
    end
  end

  describe "create" do
    it "will save a new work and redirect" do
      test_work = {
        "work": {
          category: "book",
          title: "50 shades of Manny",
          creator: "fanfic.net",
          description: "not worth it",
        },
      }

      expect {
        post works_path, params: test_work
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: "50 shades of Manny")
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal "50 shades of Manny"
      expect(new_work.category).must_equal "book"

      expect(flash[:success]).must_equal "Medium added successfully"
      must_respond_with :redirect
    end

    # it "will flash error if doesnt work" do
    #   test_work = {
    #     "work": {
    #     },
    #   }

    # expect(flash[:error]).must_equal existence?
    # end
  end

  describe "update" do
    it "will update an existing medium" do
      tester = works(:one)

      test_work = {
        "work": {
          category: "book",
          title: "50 shades of Manny",
          creator: "fanfic.net",
          description: "not worth it",
        },
      }

      expect {
        patch work_path(tester.id), params: test_work
      }.wont_change "Work.count"

      must_respond_with :redirect
      tester.reload
      expect(tester.title).must_equal test_work[:work][:title]
    end

    it "will re render on fail" do
      tester = works(:one)
      test_work = {
        "work": {
          title: "",
        },
      }

      assert_template :edit
      #do I need a gem? should really look into

    end
  end

  describe "destroy" do
    it "will delete something" do
      tester = works(:one)
      expect {
        delete work_path(tester.id)
      }.must_change "Work.count", -1

      expect(flash[:success]).must_equal "you KILLED it"
      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
end
