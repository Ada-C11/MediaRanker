require "test_helper"

describe Work do
  let(:work) {
    new_work_title = "Star Wars: A New Hope"
    new_work_creator = "George Lucas"
    new_work_description = "A young Luke Skywalker is torn from his childhood home at the mysterious appearance of two robots and a wizened sorcerer, one of whom holds the secret to defeating an intergalactic empire."
    new_work_pub = "1977"

    valid_work_params = {
      work: {
        title: new_work_title,
        creator: new_work_creator,
        description: new_work_description,
        publication_year: new_work_pub,
        category: "movie",
      },
    }

    Work.new(valid_work_params)
  }

  it "must be valid" do
    value(work).must_be :valid?
  end
end
