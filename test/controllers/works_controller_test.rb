require "test_helper"

describe WorksController do
  let (:work) {
    Work.create!(
      category: "movie", 
      title: "Rush Hour 2", 
      author: "Brett Ratner", 
      publication_year: 2001, 
      description: "After an explosion at the US Embassy in Hong Kong kills two customs agents investigating currency smuggling, Inspector Lee (Jackie Chan) and James Carter (Chris Tucker) search for the mastermind. Ricky Tan (John Lone), head of the Fu-Cang-Long Triad, sends out his minions to insure that Carter and Lee don't solve the case.")
  }
 
  describe "index" do
    it "should get to the index" do
      get works_path
      
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "can get a valid work" do
      get work_path(work.id)
      
      must_respond_with :success
    end
    
    it "throws an error when looking for an invalid work" do
      get work_path(-1)
      
      must_respond_with :redirect
      expect(flash[:error]).must_equal "That item cannot be found or no longer exists."
    end
  end
  
  describe "new" do
    it "can get to the new work page" do
      get new_user_path
      
      must_respond_with :success
    end
  end 
  
  describe "create" do
    it "will add the new work to the database" do
      work_data = {
        work: {
          category: "album", 
          title: "Ain't That Good News", 
          author: "Sam Cooke", 
          publication_year: 1964, 
          description: "Ain't That Good News is the thirteenth and final studio album by American R&B and soul singer-songwriter Sam Cooke, released March 1, 1964, on RCA Victor Records, in both mono and stereo, LPM 2899 and LSP 2899."    
        }
      }
    
      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1
      
    end
  end
  
  describe "edit" do
    it "get the edit path" do
      get edit_work_path(work.id)
      
      must_respond_with :success
    end
    
    it "will return a NOT FOUND response for a nonexistent work" do
      work_id = Work.last.id + 1
      get edit_work_path(work_id)
      
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    let(:work_data) {
      {
        work:{
          title: "FAKE NEWS",
        }
      }
    }
    it "changes the data on the model" do
      work.assign_attributes(work_data[:work])
      expect(work).must_be :valid?
      work.reload
      
      patch work_path(work), params: work_data
      
      must_respond_with :redirect
      must_redirect_to work_path(work)
      
      expect(flash[:status]).must_equal :success
      
      work.reload
      expect(work.title).must_equal(work_data[:work][:title])
    end
  end
  
end
