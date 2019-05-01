require "test_helper"

describe WorksController do
  let(:work) { works(:book) }

  describe "paths" do
    it "should get homepage from root" do
      get root_path

      must_respond_with :success
    end
    it "should get index" do
      # Action
      get works_path
      # Assert
      must_respond_with :success
    end
  end
  # describe "show" do
  #   it "should be OK to show an existing, valid work" do

  #     # Arrange
  #     # book = Book.create(title: "test book", author_id: Author.create(name: "test").id)
  #     valid_work_id = works(:oop_part_two).id

  #     # Act
  #     get work_path(valid_work_id)

  #     # Assert
  #     must_respond_with :success
  #   end

  #   it "should give a flash notice instead of showing a non-existant, invalid work" do

  #     # Arrange
  #     work = works(:oop_part_two)
  #     invalid_work_id = work.id
  #     work.destroy

  #     # Act
  #     get work_path(invalid_work_id)

  #     # Assert
  #     must_respond_with :redirect
  #     expect(flash[:error]).must_equal "Unknown work"
  #   end
  # end
end
