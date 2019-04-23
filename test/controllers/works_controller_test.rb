require "test_helper"

describe WorksController do
  it "should get category:string" do
    get works_category:string_url
    value(response).must_be :success?
  end

  it "should get title:string" do
    get works_title:string_url
    value(response).must_be :success?
  end

  it "should get author:string" do
    get works_author:string_url
    value(response).must_be :success?
  end

  it "should get publication_year:integer" do
    get works_publication_year:integer_url
    value(response).must_be :success?
  end

  it "should get description:string" do
    get works_description:string_url
    value(response).must_be :success?
  end

end
