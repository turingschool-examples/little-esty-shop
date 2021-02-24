FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity) {|n| n + 10 }
    sequence(:unit_price) {|n| n + 1.50 }
    status { [0, 1, 2].sample }
    item
    invoice
  end
end
