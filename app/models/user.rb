# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true

  enum :role, { sample1: 0, sample2: 1, sample3: 2 }
end
