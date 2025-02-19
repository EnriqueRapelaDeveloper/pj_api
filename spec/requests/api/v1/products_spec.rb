require 'swagger_helper'

RSpec.describe 'api/v1/products', type: :request do

  path '/api/v1/products' do  

    get('show products') do
      tags 'Products'
      description 'See products'
      operationId 'showProducts'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/products'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create product') do
      tags 'Products'
      description 'Create a product'
      operationId 'createProduct'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :product, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/create_product' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/product'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'invalid request') do
        schema '$ref' => '#/components/schemas/generic_error'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/products/{uuid}' do
    parameter name: :uuid, :in => :path, :type => :string

    get('show product') do
      tags 'Products'
      description 'See a product'
      operationId 'showProduct'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/product'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/generic_error'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update product') do
      tags 'Products'
      description 'Update a product'
      operationId 'updateProduct'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :product, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/create_product' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/product'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          } 
        end
        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/generic_error'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'invalid request') do
        schema '$ref' => '#/components/schemas/generic_error'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete product') do
      tags 'Products'
      description 'Delete a product'
      operationId 'deleteProduct'
      consumes 'application/json'
      produces 'application/json'

      response(204, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/generic_error'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end 
  end
end