require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  path '/auth/login' do
    post 'User Login' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      security []

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'armando@test.com' },
          password: { type: :string, example: '123' }
        },
        required: [ 'email', 'password' ]
      }

      let(:user) { create(:user, password: 'password123') }
      response '200', 'Login Successful' do
        let(:credentials) { { email: user.email, password: 'password123' } }
        run_test!
      end

      response '401', 'Invalid Credentials' do
        let(:credentials) { { email: user.email, password: 'wrong_password' } }
        run_test!
      end
    end
  end
end
