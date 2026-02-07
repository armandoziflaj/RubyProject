# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'ToAPIs API v1',
        version: 'v1',
        description: 'Todo API με JWT Authentication'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Development Server'
        }
      ],
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT
          }
        }
      },
      security: [{ bearer_auth: [] }]
    }
  }

  config.openapi_format = :yaml
end