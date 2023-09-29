require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users/new_session' do

    post('new_session user') do
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
