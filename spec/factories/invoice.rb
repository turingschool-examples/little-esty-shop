# FactoryBot.define do
#   factory :invoice, class: Invoice do
#     status {Faker::Number.within(range: 0..2)}
#     association :item, factory: :item
#     association :merchant
#   end
# end
