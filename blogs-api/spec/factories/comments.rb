FactoryBot.define do
  factory :comment do
    content { "MyString" }
    blog { nil }
    user { nil }
  end
end
