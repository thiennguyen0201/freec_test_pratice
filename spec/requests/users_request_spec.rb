require 'rails_helper'
require 'jwt'

RSpec.describe Api::V1::Admin::UsersController, type: :request do
  let(:admin) { create(:user, :admin) }
  let(:token) do
    JWT.encode(
      {
        user_id: admin.id,
        expired: 7.days.from_now.to_i
      },
      Rails.application.secret_key_base
    )
  end

  let(:headers) do
    {
      'Authorization' => 'Bearer ' + token
    }
  end

  describe 'GET' do
    let!(:users) { create_list(:user, 3) }
    it 'returns users' do
      get '/api/v1/admin/users', headers: headers

      expect(JSON.parse(response.body)['users'].size).to eq(users.size + 1)
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH' do
    subject do
      patch("/api/v1/admin/users/#{user.id}", params:, headers: headers)
    end

    context 'when role is admin' do
      let(:user) { create(:user, :admin) }
      let(:params) { { name: Faker::Name.name } }
      it 'not allowed to update admin' do
        subject
        expect(response.status).to eq(401)
      end
    end

    context 'when role is user' do
      context 'with valid params' do
        let(:user) { create(:user) }
        let(:params) do
          {
            name: Faker::Name.name,
            email: Faker::Internet.email
          }
        end

        it 'updates user' do
          subject

          expect(JSON.parse(response.body)['user']['email']).to eq(params[:email])
          expect(JSON.parse(response.body)['user']['name']).to eq(params[:name])
          expect(response.status).to eq(200)
        end
      end

      context 'with invalid params' do
        let(:user) { create(:user) }
        let(:params) do
          {
            name: '',
            email: ''
          }
        end

        it 'returns errors' do
          subject

          expect(response.status).to eq(422)
        end
      end
    end
  end

  describe 'DELETE' do
    subject do
      delete("/api/v1/admin/users/#{user.id}", headers: headers)
    end

    context 'when role is admin' do
      let(:user) { create(:user, :admin) }
      it 'not allowed to delete admin' do
        subject
        expect(response.status).to eq(401)
      end
    end

    context 'when role is user' do
      let(:user) { create(:user) }

      it 'deletes user' do
        subject

        expect(User.where(id: user.id)).to_not exist
        expect(response.status).to eq(200)
      end
    end
  end
end
