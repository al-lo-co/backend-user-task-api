module Mutations
  module Users
    class CreateUser < Mutations::BaseMutation
      argument :email, String, required: true
      argument :full_name, String, required: true
      argument :role, Integer, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [ String ], null: false

      def resolve(email:, full_name:, role:, password:, password_confirmation:)
        user = User.new(email: email, full_name: full_name, role: role, password: password, password_confirmation: password_confirmation)

        if user.save
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
