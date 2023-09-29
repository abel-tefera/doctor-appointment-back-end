require 'swagger_helper'

RSpec.describe 'api/v1/doctors', type: :request do
  path '/api/v1/doctors' do
    get('list doctors') do
      produces 'application/json'
      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   bio: { type: :string },
                   hospital: { type: :string },
                   specialization: { type: :string },
                   rate: { type: :number },
                   image: { type: :string }
                 },
                 required: %w[id name bio hospital specialization rate image]
               }
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

  path '/api/v1/doctors' do
    post 'Creates a doctors' do
      consumes 'multipart/form-data'
      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          bio: { type: :text },
          hospital: { type: :string },
          specialization: { type: :string },
          rate: { type: :number },
          image: { type: :text },
          user_id: { type: :number }
        },
        required: ['name', 'bio', 'hospital', 'specialization', 'rate', 'image', ' user_id']
      }

      response '201', 'doctor created' do
        let(:doctor) do
          { name: 'foo', bio: 'bar', hospital: 'bar', specialization: 'bar', rate: 10,
            image: 'image', user_id: 1 }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:doctor) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/doctors/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete doctor') do
      response('204', 'successful') do
        let(:id) { '123' }

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

  path '/api/v1/doctors/main' do
    get('three_first_doctors doctor') do
      response(200, 'successful') do
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
