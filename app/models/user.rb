# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_many :tasks
  has_secure_password

  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum :role, { sample1: 0, sample2: 1, sample3: 2 }
end
