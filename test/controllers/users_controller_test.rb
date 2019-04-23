require "test_helper"

describe UsersController do
  let (:user) {
    User.create! name: "PhDPlayerHatersDegree"
  }
  
  describe "index" do
    it "can get to the index" do
      get users_path
      
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid user" do
      get user_path(user.id)
      
      must_respond_with :success
    end
    
    it "displays an error message when no user is found" do
      get user_path(-1)
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "That user cannot be found or no longer exists."
    end
  end

  describe "new" do
    it "can get to the new user page" do
      get new_user_path
      
      must_respond_with :success
    end
  end 
  
  describe "create" do
    it "will add the user to the database" do
      user_data = {
        user: {
          name: "FakeUsername",
        }
      }
    
      expect {
        post users_path, params: user_data
      }.must_change "User.count", +1
      
    end
    
    # it "will raise an error if the user was not created" do
    #   user_data = {
    #     user: {
    #       name: "",
    #     }
    #   }
    #   expect(User.new(user_data[:user])).wont_be :valid?
      
    #   expect {
    #     post users_path, params: user_data
    #   }.wont_change "User.count"
    # end
  end
 
end
