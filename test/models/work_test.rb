require "test_helper"

describe Work do
  let(:work) { Work.new }
  
  describe "validations" do
    before do
      work_data = {
          category: "album", 
          title: "Ain't That Good News", 
          author: "Sam Cooke", 
          publication_year: 1964, 
          description: "Ain't That Good News is the thirteenth and final studio album by American R&B and soul singer-songwriter Sam Cooke, released March 1, 1964, on RCA Victor Records, in both mono and stereo, LPM 2899 and LSP 2899."    
      }
      
       @work = Work.new(work_data)
       
    end
    
  it "is valid when fields are present" do
    result = @work.valid?
    
    expect(result).must_equal true
    end

  
  it "is invalid with missing author" do
    @work.author = nil
    
    result = @work.valid?
    
    expect(result).must_equal false
  end
  
  it "is invalid with missing title" do
    @work.title = nil
    
    result = @work.valid?
    
    expect(result).must_equal false
  end
  
  it "is invalid with missing category" do
    @work.category = nil
    
    result = @work.valid?
    
    expect(result).must_equal false
  end
  
  end
  
  # describe "Ranked Media" do
  #   it "displays the homepage even with no entries" do
      
  #   end
  # end
end