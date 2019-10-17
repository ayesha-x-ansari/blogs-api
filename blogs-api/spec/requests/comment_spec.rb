# spec/requests/comments_spec.rb
require 'rails_helper'

RSpec.describe 'Comments API' do
  # Initialize the test data
  let(:user) { create(:user) }
  let!(:blog) { create(:blog, user_id: user.id) }
  let!(:comments) { create_list(:comment, 20, blog_id: blog.id,user_id: user.id) }
  let(:blog_id) { blog.id }
  let(:user_id) { user.id }
  let(:id) { comments.first.id }

  # Test suite for GET /blogs/:blog_id/comments
  describe 'GET /blogs/:blog_id/comments' do
    before { get "/blogs/#{blog_id}/comments" }

    context 'when blog exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all blog comments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when blog does not exist' do
      let(:blog_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Blog/)
      end
    end
  end

  # # Test suite for GET /blogs/:blog_id/comments/:id
  describe 'GET /blogs/:blog_id/comments/:id' do
    before { get "/blogs/#{blog_id}/comments/#{id}" }

    context 'when blog comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when blog comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # # Test suite for POST /blogs/:blog_id/comments
  describe 'POST /blogs/:blog_id/comments' do
    let(:valid_attributes) { { content: 'This post is awesome', blog_id: blog_id, user_id: user_id } }

    context 'when request attributes are valid' do
      before { post "/blogs/#{blog_id}/comments", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/blogs/#{blog_id}/comments", params: {user_id:1} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  # # Test suite for PUT /blogs/:blog_id/comments/:id
  describe 'PUT /blogs/:blog_id/comments/:id' do
    let(:valid_attributes) { { content: 'Hello World' } }

    before { put "/blogs/#{blog_id}/comments/#{id}", params: valid_attributes }

    context 'when comment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        updated_comment = Comment.find(id)
        expect(updated_comment.content).to match(/Hello World/)
      end
    end

    context 'when the comment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
   end

  # # Test suite for DELETE /blogs/:id
  describe 'DELETE /blogs/:id' do
    before { delete "/blogs/#{blog_id}/comments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end