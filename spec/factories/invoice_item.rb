FactoryBot.define do
  factory :invoice_item do
    sequence :unit_price do |n|
      n * 2
    end
    status { :shipped }
    sequence :quantity do |n|
      n * 3
    end
    item
    invoice
  end
end
