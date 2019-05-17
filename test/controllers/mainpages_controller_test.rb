require 'test_helper'

describe MainpagesController do
  it 'can get the mainpage' do
    get root_path

    must_respond_with :success
  end
end
