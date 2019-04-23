require "test_helper"

describe WorksController do
  it 'can list all media' do
    get works_path
    must_respond_with :success
  end
end
