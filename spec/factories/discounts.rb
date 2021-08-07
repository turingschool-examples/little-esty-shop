FactoryBot.define do
  factory :discount do
    name { "MyString" }
    threshold { 1 }
    percentage { 1 }
    merchant { nil }
  end
end
