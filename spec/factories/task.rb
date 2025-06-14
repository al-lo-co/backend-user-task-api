FactoryBot.define do
  factory :task do
    description { Faker::Lorem.sentence }
    status { 'active' }
    date { DateTime.now }
    user { create(:user) }
  end
end
