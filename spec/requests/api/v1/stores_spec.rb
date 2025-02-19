require 'swagger_helper'

RSpec.describe 'api/v1/stores', type: :request do

  path '/api/v1/stores' do  

    get('show stores') do
      tags 'Stores'
      description 'See stores'
      operationId 'showStores'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/stores'
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

    post('create store') do
      tags 'Stores'
      description 'Create a store'
      operationId 'createStore'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :store, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/create_store' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/store'
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

  path '/api/v1/stores/{uuid}' do
    parameter name: :uuid, :in => :path, :type => :string

    get('show store') do
      tags 'Stores'
      description 'See a store'
      operationId 'showStore'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/store'
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

    put('update store') do
      tags 'Stores'
      description 'Update a store'
      operationId 'updateStore'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :store, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/create_store' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/store'
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

    delete('delete store') do
      tags 'Stores'
      description 'Delete a store'
      operationId 'deleteStore'
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

  path '/api/v1/stores/{uuid}/assign_products' do
    parameter name: :uuid, :in => :path, :type => :string

    post('assign products to store') do
      tags 'Stores'
      description 'Assign products to a store'
      operationId 'assignProductsToStore'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :product_uuids, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/assign_products' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/store'
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
  end 

  path '/api/v1/stores/{uuid}/unassign_products' do
    parameter name: :uuid, :in => :path, :type => :string

    delete('unassign products from store') do
      tags 'Stores'
      description 'Unassign products from a store'
      operationId 'unassignProductsFromStore'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :product_uuids, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/assign_products' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/store'
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
  end

  path '/api/v1/stores/{uuid}/products' do
    parameter name: :uuid, :in => :path, :type => :string

    get('show products of store') do
      tags 'Stores'
      description 'See the products of a store' 
      operationId 'showProductsOfStore'
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