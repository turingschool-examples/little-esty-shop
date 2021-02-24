FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity) {|n| n + 10 }
    sequence(:unit_price) {|n| n + 1.50 }
    status { [0, 1, 2].sample }
    item
    invoice

    factory :invoice_item_with_invoices do
      sequence(:quantity) {|n| n + 10 }
      sequence(:unit_price) {|n| n + 1.50 }
      status { [0, 1, 2].sample }

      transient do
        invoice_count { 5 }
      end

      after(:create) do |ii, amount|
        create_list(:invoice_with_customers, amount.invoice_count, invoice_items: [ii])
      end

    factory :invoice_item_with_items do
      sequence(:quantity) {|n| n + 10 }
      sequence(:unit_price) {|n| n + 1.50 }
      status { [0, 1, 2].sample }

      transient do
        item_count { 5 }
      end

        after(:create) do |ii, amount|
          create_list(:item_with_merchant, amount.item_count, invoice_items: [ii])
        end
      end
    end
  end
end
