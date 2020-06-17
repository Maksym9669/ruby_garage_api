FactoryBot.define do
    factory :user do
      sequence(:email) { |n| "test-1@sample.com" }
      password { "123456" }
    end
end