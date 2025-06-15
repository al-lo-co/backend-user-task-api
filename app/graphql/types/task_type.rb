module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: false
    field :status, Integer, null: false
    field :date, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
