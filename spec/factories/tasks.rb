FactoryBot.define do
  factory :task do
    name { "MyString" }
    status { "active" }

    factory :second_task do
      name { "MyString2" }
    end
  end
end
