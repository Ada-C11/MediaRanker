require "test_helper"

describe WorksController do
  let (:work) {
    Work.create title: 'the witching hour'
  }

  describe "index" do
    it "can get the index path" do
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
          it "returns status code 200" do
            get new_work_path
            must_respond_with :ok
          end
        end

        it "creates work" do
      expect {
        post works_url, params: { title: {  } }
      }.must_change "Work.count"

      must_redirect_to user_path(Work.last)
    end

    describe "edit" do
      it "can edit an existing work" do
        get edit_work_path(work.title)
        must_respond_with :success
      end
    end

    it "updates work" do
     patch work_url(work), params: { work: {  } }
     must_redirect_to work_path(work)
   end

      describe "show" do
        it "can get a valid work" do
          get works_path(work.title)
          must_respond_with :success
        end
      end

      describe "destroy" do
        it "destroys the work from the database" do
            delete work_path(work.title)

          must_respond_with :redirect
          must_redirect_to works_path

          after_work = Work.find_by(title: work.title)
          expect(after_title).must_be_nil
        end
end
