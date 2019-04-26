require "test_helper"

describe "WorksController" do
  describe "index" do
    it "renders without crashing" do
      # Arrange

      # Act
      get works_path

      # Assert
      must_respond_with :ok
    end

    it "renders even if there are zero books" do
      # Arrange
      Work.destroy_all

      # Act
      get works_path

      # Assert
      must_respond_with :ok
    end
  end

  describe "new" do
    it "retruns status code 200" do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates a new work" do
      # Arrange
      work_data = {
        work: {
          title: "Becoming",
          creator: "Michelle Obama",
          description: "The memoir of the former first lady",
          category: "book",
          publication_year: 2018,
        },
      }

      # Act
      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1

      # Assert
      must_respond_with :redirect
      # must_redirect_to work_path (add once details page is added)

      check_flash

      work = Work.last
      expect(work.title).must_equal work_data[:work][:title]
      expect(work.creator).must_equal work_data[:work][:creator]
      expect(work.description).must_equal work_data[:work][:description]
      expect(work.category).must_equal work_data[:work][:category]
      expect(work.publication_year).must_equal work_data[:work][:publication_year]
    end

    it "sends back bad_request if no work data is sent" do
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
end
