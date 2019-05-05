require "test_helper"

describe UsersController do
    let (:user) {
      User.create name: 'chantal'
    }
  end

    describe "index" do
      it "can get the index path" do
        get users_path
        must_respond_with :success
      end

      describe "new" do
        it "returns status code 200" do
          get new_user_path
          must_respond_with :ok
        end
      end

      it "creates user" do
    expect {
      post users_url, params: { user: {  } }
    }.must_change "User.count"

    must_redirect_to user_path(User.last)
  end

  describe "edit" do
    it "can edit an existing user" do
      get edit_user_path(user.name)
      must_respond_with :success
    end
  end

  it "updates user" do
   patch user_url(user), params: { user: {  } }
   must_redirect_to user_path(user)
 end

    describe "show" do
      it "can get a valid user" do
        get users_path(user.name)
        must_respond_with :success
      end
    end

    describe "destroy" do
      it "logs out the user from the database" do
          delete user_path(user.name)

        must_respond_with :redirect
        must_redirect_to users_path

        after_user = User.find_by(name: user.name)
        expect(after_user).must_be_nil
      end

###CONTROLLER TESTS###

  describe "current" do
    it "responds with 200 ok for a logged-in user" do
      user = user.first
      login_data = {
      user: {
        username:  user.username
      },
    }

    post login_path, params: login_data
    expect(session[:user_id]).must_equal user.id

    get current_user_path

    must_respond_with :ok


  #   it "works with no users" do
  #     user.destroy
  #     get users_path
  #     must_respond_with :success
  #   end
  # end
  #
  #
    #
    #   it "flashes an error if the user does not exist" do
    #     user_id = 123456789
    #
    #     patch user_path(user_id), params: {}
    #
    #     must_respond_with :redirect
    #     expect(flash[:error]).must_equal "Could not find driver with id: #{driver_id}"
    #   end
    # end

    # describe "create" do
    #   it "can create a new user" do
    #     user_hash = {
    #       driver: {
    #         name: "lavender",
    #         vin: '12345678901234569'
    #       },
    #     }
    #
    #     post drivers_path, params: driver_hash
    #
    #     new_driver = Driver.find_by(vin: driver_hash[:driver][:vin])
    #     expect(new_driver.name).must_equal driver_hash[:driver][:name]
    #
    #     must_respond_with :redirect
    #     must_redirect_to drivers_path
    #   end
    # end

    # #HELP
    # describe "update" do
    #   it "can update an existing user" do
    #     user_hash = {
    #       name: {
    #         # name: 'percy',
    #         # vin: '12345678901234568'
    #       }
    #     }
    #     patch user_path(user.id), params: user_hash
    #
    #     updated_user = User.find_by(name: user_hash[:user][:name])
    #     expect(updated_user.vin).must_equal driver_hash[:driver][:vin]
    #
    #     must_respond_with :redirect
    #     must_redirect_to drivers_path
    #   end
  #
  #     it "flashes an error if the driver does not exist" do
  #       driver_id = 123456789
  #
  #       expect {
  #         delete driver_path(driver_id)
  #       }.wont_change "Driver.count"
  #
  #       must_respond_with :redirect
  #       expect(flash[:error]).must_equal "Could not find driver with id: #{driver_id}"
  #     end
  #   end
  # end


end
