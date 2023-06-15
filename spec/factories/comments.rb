FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    association :author, factory: :user
    association :subject, factory: :project
  end
end
