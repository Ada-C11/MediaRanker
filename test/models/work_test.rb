require "test_helper"

describe Work do

  it "must be valid" do
    result  = works(:summer).valid?
    expect(result).must_equal true
  end

  it "is not valid for a work without a title" do
    work_data = {
      work: {
        category: "book",
        title: "",
        creator: "Andre Aciman",
        publication_year: 2015,
        description: "book i just read"
      }
    }
    expect(Work.create(work_data[:work])).wont_be :valid?
  end

  it "returns a random work for spotlight method" do
    expect(Work.spotlight).must_be_instance_of Work
  end

  it "spotlight method works with no works" do
    Work.delete_all
    expect(Work.spotlight).must_be_nil
  end

  it "top method works" do
    expect(Work.top("book")).must_be_instance_of Array
    expect(Work.top("book").first).must_be_instance_of Work
  end

  it "top method returns empty arrays with no works" do
    Work.delete_all
    expect(Work.top("book")).must_be_instance_of Array
    expect(Work.top("book").first).must_be_nil
  end

  it "top method works in the case of a tie " do
    20.times do
      tie = Work.create(title:"tie test", category: "book")
      Vote.create(user_id: users(:niv).id, work_id: tie.id)
    end

    expect(Work.top("book")).must_be_instance_of Array
    expect(Work.top("book").first).must_be_instance_of Work
    expect(Work.top("book").length).must_equal 10
    expect(Work.top("book").first.title).must_equal "tie test"
  end


end
