require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    value(user).must_be :valid?
  end

  describe "Relationships" do
  end

  describe "Validations" do
  end

  describe "Custom Methods" do
  end
end
