require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "Relationships" do
  end

  describe "Validations" do
  end

  describe "Custom Methods" do
  end
end
