require "test_helper"

describe WorksController do
   it "will show index page successfully" do
     get works_path

     must_respond_with :ok
   end
end
