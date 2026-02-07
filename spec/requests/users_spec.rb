require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/signup' do
    post 'User Registration' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      security []

      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Armando' },
          email: { type: :string, example: 'armando@test.com' },
          password: { type: :string, example: 'password123' },
          password_confirmation: { type: :string, example: 'password123' }
        },
        required: [ 'name', 'email', 'password', 'password_confirmation' ]
      }

      response '201', 'User created successfully' do
        let(:user_params) do
          {
            name: 'Armando',
            email: "armando_#{rand(1000)}@test.com",
            password: 'password123',
            password_confirmation: 'password123'
          }
        end
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:user_params) { { name: 'Armando' } }
        run_test!
      end
    end
  end
  path '/auth/logout' do
    get 'Logout' do
      tags 'Authentication'
      security [bearer_auth: []]

      response '200', 'Logout successful' do
        let(:user) { create(:user) }
        let(:Authorization) { "Bearer #{token_generator(create(:user).id)}" }
        run_test!
      end
    end
  end
end