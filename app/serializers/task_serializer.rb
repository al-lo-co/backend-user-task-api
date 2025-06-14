class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :date, :user_id
end
