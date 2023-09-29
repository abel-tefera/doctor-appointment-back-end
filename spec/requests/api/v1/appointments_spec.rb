require 'swagger_helper'

RSpec.describe 'api/v1/appointments', type: :request do
  path '/api/v1/appointments' do
    post('create appointment') do
      consumes 'application/json'
      parameter name: :appointment, in: :body, schema: {
        type: :object,
        properties: {
          appointment_date: { type: :date, default: Date.today },
          doctor_id: { type: :number },
          user_id: { type: :number }
        },
        required: %w[appointment_date doctor_id user_id]
      }

      response '201', 'appointment created' do
        let(:appointment) { { user_id: 1, appointment_date: Date.today, doctor_id: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:appointment) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/appointments/find_all' do
    post('find_all appointment') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :appointment, in: :body, schema: {
          type: :object,
          properties: {
            user_id: { type: :number }
          },
          required: ['user_id']
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
end
