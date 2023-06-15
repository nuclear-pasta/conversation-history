FactoryBot.define do
  factory :project do
    name { Faker::Lorem.word }
    state {'draft' }
  end
end
