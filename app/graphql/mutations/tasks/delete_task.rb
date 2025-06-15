module Mutations
  module Tasks
    class DeleteTask < Mutations::BaseMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false
      field :errors, [ String ], null: false
      def resolve(id:)
        task = Task.find_by(id: id)

        return { success: false, errors: [ "Task not found" ] } unless task

        if task.destroy
          { success: true, errors: [] }
        else
          { success: false, errors: task.errors.full_messages }
        end
      end
    end
  end
end
