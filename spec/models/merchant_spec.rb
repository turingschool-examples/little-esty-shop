require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = Merchant.create!(name: "Larry's Lucky Ladles")
    @merchant_2 = Merchant.create!(name: "Bob's Burgers")

    @item_1 = Item.create!(name: "Star Wars Ladle", description: "May the soup be with you", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Sparkle Ladle", description: "Serve in style", unit_price: 12, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Burger Bun Bookends", description: "Books between buns", unit_price: 40, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: "Burger Bun Slippers", description: "Buns for your feet", unit_price: 30, merchant_id: @merchant_2.id)

    @customer_1 = Customer.create!(first_name: "Sally", last_name: "Brown")
    @customer_2 = Customer.create!(first_name: "Morgan", last_name: "Freeman")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @customer_2.id)

    @ii_1 = InvoiceItem.create!(quantity: 1, unit_price: 10, status: 1, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 12, status: 2, item_id: @item_2.id, invoice_id: @invoice_1.id)
    @ii_3 = InvoiceItem.create!(quantity: 1, unit_price: 40, status: 0, item_id: @item_3.id, invoice_id: @invoice_2.id)
    @ii_4 = InvoiceItem.create!(quantity: 1, unit_price: 30, status: 2, item_id: @item_4.id, invoice_id: @invoice_2.id)

    @transaction_1 = Transaction.create!(credit_card_number: "5522 3344 8811 7777", credit_card_expiration_date: "2025-05-17", result: 0, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "5555 4444 3333 2222", credit_card_expiration_date: "2023-02-11", result: 0, invoice_id: @invoice_1.id)
    @transaction_3 = Transaction.create!(credit_card_number: "5551 4244 3133 2622", credit_card_expiration_date: "2027-01-01", result: 0, invoice_id: @invoice_1.id)
    @transaction_4 = Transaction.create!(credit_card_number: "5775 4774 3373 2722", credit_card_expiration_date: "2030-07-22", result: 0, invoice_id: @invoice_1.id)

  end
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'class methods' do
    it 'returns the top five items by revenue' do
    end
  end
end
