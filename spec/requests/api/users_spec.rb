require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { valid_headers(user) }

  let(:params) do
    {
      full_name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:invalid_params) do
    {
      full_name: '',
      email: '',
      password: '',
      password_confirmation: ''
    }
  end

  describe 'GET /api/users' do
    it 'returns all tasks' do
      get api_users_path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(body.size).to be >= 1
    end
  end

  describe 'GET /api/users/:id' do
    context 'with valid ID' do
      it 'returns the user' do
        get api_user_path(id: user.id), headers: headers

        expect(response).to have_http_status(:ok)
        expect(body["id"]).to eq(user.id)
      end
    end

    context 'with invalid ID' do
      it 'returns not found' do
        get api_user_path(id: 0), headers: headers

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/users' do
    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post api_users_path, headers: headers, params: { user: params }.to_json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create user and returns error' do
        post api_users_path, headers:, params: { user: invalid_params }.to_json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/users/:id' do
    context 'with valid params' do
      let(:full_name) { Faker::Name.name }
      it 'updates the user' do
        put api_user_path(id: user.id), headers:, params: { user: { full_name: } }.to_json

        expect(response).to have_http_status(:ok)
        expect(user.reload.full_name).to eq(full_name)
      end
    end

    context 'with invalid params' do
      it 'returns an error' do
        put api_user_path(id: user.id), headers:, params: { user: { email: '' } }.to_json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/users/:id' do
    it 'deletes the user' do
      expect {
        delete api_user_path(id: user.id), headers: headers
      }.to change(User, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
