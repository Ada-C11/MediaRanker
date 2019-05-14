require "test_helper"

describe WorksController do
  let(:work) { works(:book) }
  let(:work_two) { works(:album) }

  describe "index action" do
    it "show works index page" do
      get works_path

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
      expect(flash[:failure]).must_equal "No related media found"
    end
  end
end
