module Mutations
  module Tasks
    class UpdateTask < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :description, String, required: false
      argument :status, String, required: false
      argument :date, GraphQL::Types::ISO8601Date, required: false
      argument :user_id, ID, required: false

      field :task, Types::TaskType, null: true
      field :errors, [ String ], null: false

      def resolve(id:, **attributes)
        task = Task.find(id)

        if task.update(attributes)
          { task: task, errors: [] }
        else
          { task: nil, errors: task.errors.full_messages }
        end
      end
    end
  end
end
