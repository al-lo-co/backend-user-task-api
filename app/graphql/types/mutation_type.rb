# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_task, mutation: Mutations::Tasks::CreateTask
    field :update_task, mutation: Mutations::Tasks::UpdateTask
    field :delete_task, mutation: Mutations::Tasks::DeleteTask

    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :delete_user, mutation: Mutations::Users::DeleteUser
  end
end
