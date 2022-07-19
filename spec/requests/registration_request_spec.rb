require 'rails_helper'

RSpec.describe 'Api::V1::Auth::Registration', type: :request do
  describe 'POST' do
    subject do
      post('/api/v1/auth/registration',
           params:)
    end

    context 'with valid params' do
      let(:params) do
        {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: Faker::Internet.password
        }
      end

      it 'returns http created' do
        subject
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          name: Faker::Name.name,
          email: Faker::Internet.email
        }
      end

      it 'returns http unprocessable entity' do
        subject
        expect(response.status).to eq(422)
      end
    end
  end
end
