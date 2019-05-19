require 'test_helper'

describe WorksController do
  it 'should get index' do
    get works_path
    value(response).must_be :success?
  end

  describe 'show' do
    it 'should be OK to show an existing, valid media work' do
      work_id = works(:favemov).id
      puts works_path(work_id)
      get works_path(work_id)
      must_respond_with :success
    end

    it 'should give a flash notice instead of showing a non-existant, invalid work' do
      # Arrange
      work = works(:favemov)
      invalid_work_id = work.id
      work.destroy

      # Act
      get work_path(invalid_work_id)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal 'Unknown works'
    end
  end
end
