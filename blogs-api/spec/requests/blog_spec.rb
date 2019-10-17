## spec/requests/todos_spec.rb
require 'database_cleaner'
require 'support/request_spec_helper.rb'

RSpec.describe 'Blog API', type: :request do
    # add blogs owner
    let(:user) { create(:user) }
    let!(:blogs) { create_list(:blog, 10, user_id: user.id) }
    let(:blog_id) { blogs.first.id }
    # authorize request
    let(:headers) { valid_headers }
  
    describe 'GET /blogs' do
      # update request with headers
      before { get '/blogs' }
  
      it 'returns blogs' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  
    

    describe 'GET /blogs/:id' do
      before { get "/blogs/#{blog_id}"}
  
      context 'when the record exists' do
        it 'returns the blog' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(blog_id)
        end
  
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    
  

      context 'when the record does not exist' do
        let(:blog_id) { 100 }
  
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
  
        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Blog with 'id'=100/)
        end
      end
    end
  
    
     # Test suite for POST /todos
  describe 'POST /blogs' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', content: "fffffffffffffffff", user_id: user.id } }

    context 'when the request is valid' do
      before { post '/blogs', params: valid_attributes }

      it 'creates a blog' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  
      context 'when the request is invalid' do
        let(:invalid_attributes) { { title: nil } }
        before { post '/blogs', params: invalid_attributes }
  
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
  
        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: User must exist, Title can't be blank, Content can't be blank/)
        end
      end
    end
      
  
    describe 'PUT /blogs/:id' do
      let(:valid_attributes) { { title: 'Shopping' } }
  
      context 'when the record exists' do
        before { put "/blogs/#{blog_id}", params: valid_attributes }
  
        it 'updates the record' do
          expect(response.body).to be_empty
        end
  
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end
  
    describe 'DELETE /blogs/:id' do
      before { delete "/blogs/#{blog_id}" }
  
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  
  