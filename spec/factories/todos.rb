FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.word }
    created_by { nil }
  end
end
