require 'rails_helper'

RSpec.describe 'Api::V1::Auth::Login', type: :request do
  describe 'POST' do
    subject do
      post('/api/v1/auth/login',
           params:)
    end
    context 'when user existed' do
      let(:user) { create(:user) }
      let(:params) do
        {
          email: user.email,
          password: user.password
        }
      end

      it 'returns http success' do
        subject
        expect(response.status).to eq(200)
      end
    end

    context 'when user NOT existed' do
      let(:params) do
        {
          email: 'example@example.com',
          password: '123123'
        }
      end

      it 'returns http unauthorized' do
        subject
        expect(response.status).to eq(401)
      end
    end
  end
end
