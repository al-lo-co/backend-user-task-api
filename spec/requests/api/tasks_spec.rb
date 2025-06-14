require 'rails_helper'

RSpec.describe 'Api::Tasks', type: :request do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user_id: user.id) }
  let(:headers) { valid_headers(user) }

  let(:params) do
    {
      description: Faker::Lorem.paragraph,
      status: 'active',
      date: DateTime.now,
      user_id: user.id
    }
  end

  let(:invalid_params) do
    {
      description: '',
      status: nil,
      date: nil,
      user_id: nil
    }
  end

  describe 'GET /api/tasks' do
    it 'returns all tasks' do
      get api_tasks_path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(body.size).to be >= 1
    end
  end

  describe 'GET /api/tasks/:id' do
    context 'with valid ID' do
      it 'returns the task' do
        get api_task_path(id: task.id), headers: headers

        expect(response).to have_http_status(:ok)
        expect(body["id"]).to eq(task.id)
      end
    end

    context 'with invalid ID' do
      it 'returns not found' do
        get api_task_path(id: 0), headers: headers

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/tasks' do
    context 'with valid params' do
      it 'creates a new task' do
        expect {
          post api_tasks_path, headers: headers, params: { task: params }.to_json
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create task and returns error' do
        post api_tasks_path, headers:, params: { task: invalid_params }.to_json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/tasks/:id' do
    context 'with valid params' do
      let(:description) { Faker::Lorem.paragraph }
      it 'updates the task' do
        put api_task_path(id: task.id), headers:, params: { task: { description: } }.to_json

        expect(response).to have_http_status(:ok)
        expect(task.reload.description).to eq(description)
      end
    end

    context 'with invalid params' do
      it 'returns an error' do
        put api_task_path(id: task.id), headers:, params: { task: { date: '' } }.to_json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/tasks/:id' do
    it 'deletes the task' do
      expect {
        delete api_task_path(id: task.id), headers: headers
      }.to change(Task, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
