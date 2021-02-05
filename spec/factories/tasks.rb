# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Test Exercise #{n}" }
    description { 'description' }
    user { build(:user) }

    trait :empty do
      title {}
      description {}
    end
  end
end
