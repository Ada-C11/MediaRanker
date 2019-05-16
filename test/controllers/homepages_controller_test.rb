require "test_helper"

describe HomepagesController do
  before do
    @works = :mulan
  end
  it "renders without crashing" do
    # Arrange

    # Act
    get root_path

    # Assert
    must_respond_with :ok
  end

  it "renders even when there aren't any works" do
    # Arrange
    # Destroy everything in the database
    Work.destroy_all

    # Act
    get root_path

    # Assert
    must_respond_with :ok
  end
end
