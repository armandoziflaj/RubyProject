require 'swagger_helper'

RSpec.describe 'Todos API', type: :request do
  let(:user) { create(:user) }
  let(:todo) { create(:todo, created_by: user.id) }
  let(:id) { todo.id }
  let(:Authorization) { "Bearer #{token_generator(user.id)}" }

  path '/todos' do
    get 'Retrieve all user Todos' do
      tags 'Todos'
      security [bearer_auth: []]
      produces 'application/json'

      response '200', 'Success' do
        run_test!
      end
    end

    post 'Create a new Todo' do
      tags 'Todos'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Finish the project' }
        },
        required: ['title']
      }

      response '201', 'Todo Created' do
        run_test!
      end
    end
  end

  path '/todos/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'ID of the Todo'

    get 'Get a specific Todo' do
      tags 'Todos'
      security [bearer_auth: []]
      response '200', 'Success' do
        run_test!
      end

      response '404', 'Todo Not Found' do
        let(:id) { 'invalid_id' }
        run_test!
      end
    end

    put 'Update a Todo' do
      tags 'Todos'
      security [bearer_auth: []]
      consumes 'application/json'
      parameter name: :todo, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Updated title' }
        }
      }

      response '204', 'Todo Updated' do
        run_test!
      end
    end

    delete 'Delete a Todo' do
      tags 'Todos'
      security [bearer_auth: []]
      response '204', 'Todo Deleted' do
        run_test!
      end
    end
  end
end