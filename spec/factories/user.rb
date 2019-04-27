FactoryBot.define do
  factory :user do
    sequence(:mysize_id) { |n| "test#{n}"}
    sequence(:name) { |n| "test#{n}"}
    sequence(:email) { |n| "test#{n}@example.com"}
    sequence(:size) { |n| 26.5 }
  end
end