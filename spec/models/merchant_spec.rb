require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe 'instance methods' do
    describe '.most_popular_items' do
      it 'should return the 5 most popular items for some merchant in terms of
          total revenue generated' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 2500)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 1000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 40)
        item_4 = merchant_1.items.create!(name: "1984 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 60)
        item_5 = merchant_1.items.create!(name: "1991 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 90)
        item_6 = merchant_1.items.create!(name: "1993 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 70)
        item_7 = merchant_1.items.create!(name: "2004 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 20)
        item_8 = merchant_1.items.create!(name: "1997 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 10)
        item_9 = merchant_1.items.create!(name: "1996 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 10)
        item_10 = merchant_1.items.create!(name: "1975 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 40)
        customer_1 = Customer.create!(first_name: "Guthrie", last_name: "Govan")
        invoice_1 = customer_1.invoices.create!(status: 1)
        invoice_2 = customer_1.invoices.create!(status: 0)
        invoice_3 = customer_1.invoices.create!(status: 1)
        invoice_item_1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: item_1.unit_price, status: 0)
        invoice_item_2 = InvoiceItem.create!(item: item_9, invoice: invoice_1, quantity: 25, unit_price: item_9.unit_price, status: 0)
        invoice_item_3 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 1, unit_price: item_2.unit_price, status: 0)
        invoice_item_4 = InvoiceItem.create!(item: item_4, invoice: invoice_1, quantity: 31, unit_price: item_4.unit_price, status: 0)
        invoice_item_5 = InvoiceItem.create!(item: item_3, invoice: invoice_1, quantity: 35, unit_price: item_3.unit_price, status: 0)
        invoice_item_6 = InvoiceItem.create!(item: item_5, invoice: invoice_1, quantity: 10, unit_price: item_5.unit_price, status: 0)
        invoice_item_7 = InvoiceItem.create!(item: item_6, invoice: invoice_1, quantity: 17, unit_price: item_6.unit_price, status: 0)
        invoice_item_8 = InvoiceItem.create!(item: item_8, invoice: invoice_1, quantity: 22, unit_price: item_8.unit_price, status: 0)
        invoice_item_9 = InvoiceItem.create!(item: item_7, invoice: invoice_1, quantity: 1, unit_price: item_7.unit_price, status: 0)
        invoice_item_10 = InvoiceItem.create!(item: item_10, invoice: invoice_1, quantity: 4, unit_price: item_10.unit_price, status: 0)
        invoice_item_11 = InvoiceItem.create!(item: item_5, invoice: invoice_2, quantity: 10000, unit_price: item_5.unit_price, status: 0)
        invoice_item_12 = InvoiceItem.create!(item: item_7, invoice: invoice_2, quantity: 10000, unit_price: item_7.unit_price, status: 0)
        invoice_item_13 = InvoiceItem.create!(item: item_8, invoice: invoice_3, quantity: 10000, unit_price: item_8.unit_price, status: 0)
        transaction_1 = invoice_1.transactions.create!(credit_card_number: 0000111122223333, result: "success")
        transaction_2 = invoice_2.transactions.create!(credit_card_number: 0000111122223333, result: "failed")
        transaction_3 = invoice_3.transactions.create!(credit_card_number: 0000111122223333, result: "success")

        expect(merchant_1.most_popular_items).to eq([item_8, item_1, item_4, item_3, item_6])
      end
    end
  end
end
