FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number:30) }
    user
    address { "京都府京都市上京区京都御苑3" }
    receive_shuin { true }
  end
end