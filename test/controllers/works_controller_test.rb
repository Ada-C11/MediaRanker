# frozen_string_literal: true

require 'test_helper'

describe WorksController do
  let(:work) { works(:book) }

  describe 'main' do
    it 'should get main' do
      get root_path
      value(response).must_be :successful?
    end
  end

  describe 'index' do
    it 'should get index' do
      get works_path
      value(response).must_be :successful?
    end
  end

  describe 'show' do
    it 'should get show' do
      get work_path(work.id)

      must_respond_with :success
    end

    it 'will redirect if the work.id is invalid' do
      get work_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'should get new' do
      get new_work_path
      value(response).must_be :successful?
    end
  end

  describe 'create' do
    it 'can create a new work' do
      work_hash = {
        work: {
          title: 'Test Title',
          created_by: 'Test Creator',
          published: 2019,
          media: 'album'
        }
      }

      expect do
        post works_path, params: work_hash
      end.must_change 'Work.count', 1
    end

    it 'will give bad request response if there are any errors' do
      work_hash = {
        work: {
          title: '',
          created_by: 'Fake Creator',
          published: 2017,
          media: 'book'
        }
      }

      expect do
        post works_path, params: work_hash
      end.wont_change 'Work.count'

      must_respond_with :bad_request
    end
  end

  describe 'edit' do
    it 'should get edit' do
      get edit_work_path(work.id)
      value(response).must_be :successful?
    end

    it 'will respond with a redirect when attempting to edit a nonexistent work' do
      get edit_work_path(-1)
      must_respond_with :redirect
    end
  end

  describe 'update' do
    work = Work.last

    work_hash = {
      work: {
        title: 'Across the Universe',
        media: 'album',
        created_by: 'Beatles Cover Band',
        published: 2012
      }
    }

    it 'can update an existing work' do
      work = works(:album)
      expect do
        patch work_path(work.id), params: work_hash
      end.wont_change 'Work.count'
    end

    it 'will redirect to the root page if given an invalid work' do
      patch work_path(-1), params: work_hash

      must_respond_with :redirect
    end
  end

  describe 'destroy' do
    it 'can delete a work' do
      # Arrange - create a work
      new_work = Work.create(title: 'Red Rain', created_by: 'George Smith', published: 2001)
      expect do
        delete work_path(new_work.id)
      end.must_change 'Work.count', -1

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
