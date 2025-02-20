# frozen_string_literal: true

require 'rails_helper'

store_schema = YAML.load_file(Rails.root.join('spec/schemas/store.yml'))
generic_error_schema = YAML.load_file(Rails.root.join('spec/schemas/generic_error.yml'))
product_schema = YAML.load_file(Rails.root.join('spec/schemas/product.yml'))
order_schema = YAML.load_file(Rails.root.join('spec/schemas/order.yml'))

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        schemas: {
          stores: store_schema.dig('stores'),
          create_store: store_schema.dig('create_store'),
          store: store_schema.dig('store'),
          generic_error: generic_error_schema.dig('generic_error'),
          products: product_schema.dig('products'),
          create_product: product_schema.dig('create_product'),
          product: product_schema.dig('product'),
          assign_products: store_schema.dig('assign_products'),
          update_order: order_schema.dig('update_order'),
          order: order_schema.dig('order'),
          create_order: order_schema.dig('create_order')
        }
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000'
        },
        {
          url: 'https://pj-api-staging.onrender.com'
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
