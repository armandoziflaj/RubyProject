require 'swagger_helper'

RSpec.describe 'Items API', type: :request do
  let(:user) { create(:user) }
  let(:todo) { create(:todo, created_by: user.id) }
  let(:item) { create(:item, todo_id: todo.id) }

  let(:todo_id) { todo.id }
  let(:id) { item.id }
  let(:headers) do
    {
      'Authorization' => token_generator(user.id),
      'Content-Type' => 'application/json'
    }
  end
  let(:Authorization) { "Bearer #{token_generator(user.id)}" }
  path '/todos/{todo_id}/items' do
    parameter name: :todo_id, in: :path, type: :string, description: 'ID of the parent Todo'

    get 'Retrieve all items for a todo' do
      tags 'Items'
      security [ bearer_auth: [] ]
      produces 'application/json'

      response '200', 'Success' do
        run_test!
      end
    end

    post 'Create a new item' do
      tags 'Items'
      security [ bearer_auth: [] ]
      consumes 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Walk the dog' },
          done: { type: :boolean, example: false }
        },
        required: [ 'name' ]
      }

      let(:item_params) { { name: 'New Item', done: false } }
      response '201', 'Item created' do
        run_test!
      end
    end
  end

  path '/todos/{todo_id}/items/{id}' do
    parameter name: :todo_id, in: :path, type: :string
    parameter name: :id, in: :path, type: :string, description: 'ID of the item'

    get 'Retrieve a specific item' do
      tags 'Items'
      security [ bearer_auth: [] ]
      response '200', 'Success' do
        run_test!
      end
    end

    put 'Update an item' do
      tags 'Items'
      security [ bearer_auth: [] ]
      consumes 'application/json'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          done: { type: :boolean }
        }
      }
      let(:update_params) { { name: 'Updated Name', done: true } }
      response '204', 'Item updated' do
        run_test!
      end
    end

    delete 'Delete an item' do
      tags 'Items'
      security [ bearer_auth: [] ]
      response '204', 'Item deleted' do
        run_test!
      end
    end
  end
end
