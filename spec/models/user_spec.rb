require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:password) { Faker::Beer.brand }
    let(:email) { Faker::Internet.email }
    subject do
      described_class.new(
        email: email,
        password: password,
        password_confirmation: password,
        full_name: Faker::Name.name,
        role: 'sample1')
    end
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without an email' do
      subject.email = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without a password' do
      subject.password = nil
      subject.password_confirmation = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:password]).to include("can't be blank")
    end

    context "when another user has the same email" do
      let(:duplicated_user) do
        described_class.new(
          email: email,
          password: password,
          full_name: Faker::Name.name,
          password_confirmation: password,
          role: 'sample1')
      end

      it 'is invalid due to email uniqueness' do
        subject.save

        expect(duplicated_user).to_not be_valid
        expect(duplicated_user.errors[:email]).to include("has already been taken")
      end
    end
  end
end
