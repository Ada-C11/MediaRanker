require "test_helper"

describe WorksController do
  let(:user) { users(:one) }
  let(:work) { works(:one) }

  it "returns a list all works" do
    get works_path
    value(response).must_be :successful?
  end

  it "can show a valid work" do
    get work_path(work.id)
    value(response).must_be :successful?
  end

  it "will flash warning and error for invalid work" do
    get work_path(-3)
    assert_equal "Work not found.", flash[:warning]
    must_redirect_to works_path
  end

  it "can create a new work" do
    work_params = {
      "work": {
        category: "movie",
        title: "Florida",
        creator: "Florida Man",
        pub_year: 1810,
        description: "What will happen next in the Everglades?",
      },
    }

    expect {
      post works_path, params: work_params
    }.must_change "Work.count", 1

    new_work = Work.find_by(title: work_params[:work][:title])
    assert_equal "Work added", flash[:success]
    must_redirect_to work_path(new_work.id)
  end

  it "will give an error for invalid info" do
    work_params = {
      "work": {
        category: "movie",
        title: nil,
        creator: "Florida Man",
        pub_year: 1810,
        description: "What will happen next in the Everglades?",
      },
    }

    expect {
      post works_path, params: work_params
    }.wont_change "Work.count"

    assert_equal "Error:  work not added", flash[:error]
  end

  it "can edit a work" do
    get edit_work_path(work.id)
    value(response).must_be :successful?
  end

  it "can update an existing work" do
    work_params = {
      work: {
        category: "album",
        title: "Bleed American",
        creator: "Jimmy Eat World",
        publication_year: 2001,
        description: "Best album ever.",
      },
    }

    expect {
      patch work_path(work.id), params: work_params
    }.wont_change "Work.count"

    assert_equal "Changes saved", flash[:success]
    must_redirect_to work_path
  end

  it "won't update an existing work with invalid info" do
    work_params = {
      work: {
        category: nil,
        title: "Bleed American",
        creator: "Jimmy Eat World",
        publication_year: 2001,
        description: "Best album ever.",
      },
    }

    expect {
      patch work_path(work.id), params: work_params
    }.wont_change "Work.count"

    assert_equal "Error: changes not saved", flash[:error]
  end

  it "can destroy a work" do
    expect {
      delete work_path(work.id)
    }.must_change "Work.count", -1

    assert_equal "#{work.title} deleted", flash[:success]
  end

  it "cant destroy a work that doesn't exist" do
    expect {
      delete work_path(-3)
    }.wont_change "Work.count"
  end

  it "wont upvote if not logged in" do
    user = nil

    post upvote_path(work.id)
    assert_equal "A problem occurred: you must log in to vote", flash[:warning]
    must_respond_with :redirect
  end

  # Can't figure out how to test the parts of upvote that require session

  # it "will upvote valid work if logged in" do
  #   session[:user_id] = users(:three).id
  #   post upvote_path(work.id)

  #   assert_equal "Successfully upvoted!", flash[:success]
  #   must_redirect_to root_path
  # end

  # it "will raise error if upvoting invalid work" do
  #   session[:user_id] = users(:three).id
  #   post upvote_path(-3)

  #   assert_equal "Error: could not process vote", flash[:warning]
  #   must_redirect_to root_path
  # end
end
