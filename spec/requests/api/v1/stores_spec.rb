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
end