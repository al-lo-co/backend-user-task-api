require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }
  subject do
    described_class.new(
      user_id: user.id,
      description: Faker::Lorem.sentence,
      status: :active,
      date: DateTime.now)
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without an user' do
      subject.user = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:user]).to include("must exist")
    end

    it 'is invalid without a date' do
      subject.date = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:date]).to include("can't be blank")
    end
  end
end
