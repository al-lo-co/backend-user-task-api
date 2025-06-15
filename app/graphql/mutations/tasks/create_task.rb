module Mutations
  module Tasks
    class CreateTask < Mutations::BaseMutation
      argument :description, String, required: true
      argument :status, String, required: true
      argument :date, GraphQL::Types::ISO8601Date, required: true
      argument :user_id, ID

      field :task, Types::TaskType, null: true
      field :errors, [ String ], null: false

      def resolve(description:, status:, date:, user_id:)
        task = Task.new(description: description, status: status, date: date, user_id: user_id)

        if task.save
          { task: task, errors: [] }
        else
          { task: nil, errors: task.errors.full_messages }
        end
      end
    end
  end
end
