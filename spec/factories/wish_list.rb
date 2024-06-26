# frozen_string_literal: true

FactoryBot.define do
  factory :wish_list do
    association :user
    association :post
  end
end
