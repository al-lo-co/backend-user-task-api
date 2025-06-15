module Mutations
  module Users
    class UpdateUser < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :email, String, required: false
      argument :full_name, String, required: false
      argument :role, Integer, required: false
      argument :password, String, required: false
      argument :password_confirmation, String, required: false

      field :user, Types::UserType, null: true
      field :errors, [ String ], null: false

      def resolve(id:, **attributes)
        user = User.find(id)

        return { user: nil, errors: [ "User not found" ] } unless user

        if attributes[:password] && attributes[:password_confirmation].nil?
          return { user: nil, errors: [ "Password confirmation is required" ] }
        end

        if user.update(attributes)
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
