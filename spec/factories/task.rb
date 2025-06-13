FactoryBot.define do
  factory :task do
    full_name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    status { 'active' }
    date { DateTime.now }
  end
end
