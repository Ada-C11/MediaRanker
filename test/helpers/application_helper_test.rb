require "test_helper"

describe ApplicationHelper do
  describe "readable_date" do
    it "gives back something cool when date is valid" do
      # Arrange
      date = Date.today - 14

      # Act
      result = readable_date(date)

      # Assert
      expect(result).must_include date.to_s
      expect(result).must_include "15 days ago"
    end

    it "gives back the string [unknown] when date is nil" do
      result = readable_date(nil)
      expect(result).must_equal "[unknown]"
    end
  end
end
