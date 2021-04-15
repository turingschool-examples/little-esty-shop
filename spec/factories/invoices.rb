FactoryBot.define do
  factory :invoice, class: Invoice do
    status { rand(0..2) }

    association :customer, factory: :customer
  end
end

# Alternative syntax for association?
# FactoryBot.define do
#   factory :invoice do
#     customer
#     status { 0 }
#   end
# end
