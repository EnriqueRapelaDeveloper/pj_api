require 'swagger_helper'

RSpec.describe 'api/v1/orders', type: :request do
  path '/api/v1/orders' do
    post 'Create an order' do
      tags 'Orders'
      description 'Create an order'
      operationId 'createOrder'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :order, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/create_order' }

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/order'
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

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/generic_error'
        run_test!
      end
    end
  end

  path '/api/v1/orders/{uuid}' do
    parameter name: :uuid, in: :path, required: true, type: :string

    get 'Show an order' do
      tags 'Orders'
      description 'Show an order' 
      operationId 'showOrder'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/order'
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

    path '/api/v1/orders/{uuid}' do
      parameter name: :uuid, in: :path, required: true, type: :string

      put 'Update an order' do
        tags 'Orders'
        description 'Update an order'
        operationId 'updateOrder'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :order, in: :body, required: true,
                schema: { '$ref' => '#/components/schemas/update_order' }

        response(200, 'successful') do
          schema '$ref' => '#/components/schemas/order'
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

        response(404, 'not found') do
          schema '$ref' => '#/components/schemas/generic_error'
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              } 
            }
            run_test!
          end
        end 
      end
    end
  end

  path '/api/v1/orders/{uuid}/pay' do
    parameter name: :uuid, in: :path, required: true, type: :string

    post 'Pay an order' do
      tags 'Orders'
      description 'Pay an order'  
      operationId 'payOrder'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/order'
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

  path '/api/v1/orders/{uuid}/cancel' do
    parameter name: :uuid, in: :path, required: true, type: :string

    post 'Cancel an order' do
      tags 'Orders'
      description 'Cancel an order' 
      operationId 'cancelOrder'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/order'
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

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/generic_error'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
          run_test!
        end
      end
    end
  end

  path '/api/v1/orders/{uuid}/deliver' do
    parameter name: :uuid, in: :path, required: true, type: :string

    post 'Deliver an order' do
      tags 'Orders'
      description 'Deliver an order'  
      operationId 'deliverOrder'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema '$ref' => '#/components/schemas/order'
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
          run_test!
        end
      end 

      response(404, 'not found') do
        schema '$ref' => '#/components/schemas/generic_error'
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { 
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
          run_test!
        end
      end 
    end
  end
end
