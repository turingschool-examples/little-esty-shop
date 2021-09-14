FactoryBot.define do
  factory :invoice, class: Invoice do
    status { 1 }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
  end
end
