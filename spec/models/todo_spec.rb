require 'rails_helper'
require 'faker'

RSpec.describe Todo, type: :model do
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let!(:todos) { create_list(:todo, 10) }

  describe 'GET /todos' do
    before { get '/todos' }

    it 'returns todos' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end

describe 'POST /todos' do
  # Έγκυρα δεδομένα
  let(:valid_attributes) { { title: 'Learn Rails', created_by: '1' } }

  context 'when the request is valid' do
    before { post '/todos', params: valid_attributes }

    it 'creates a todo' do
      expect(JSON.parse(response.body)['title']).to eq('Learn Rails')
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when the request is invalid' do
    before { post '/todos', params: { title: 'Foobar' } }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end
  end
end