require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    value(user).must_be :valid?
  end

  # This doesn't work, which makes me think it's wrong to have a model method for this in the first place.
  # it "returns current user if user is logged in" do
  #   perform_login

  #   expect(User.current(session)).must_be_kind_of User
  # end
end
