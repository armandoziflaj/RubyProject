FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character rescue Faker::Lorem.word }
    done { false }
    todo { nil }
  end
end