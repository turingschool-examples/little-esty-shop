require 'rails_helper'

RSpec.describe InvoiceItem do
  it {should belong_to :invoice}
  it {should belong_to :item}
  it {should have_many(:merchants).through(:item)}

 describe 'class methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Cool Shirts")
      @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
      @customer_2 = Customer.create(first_name: 'Susie', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'cancelled')
      @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'in progress')
      @invoice_3 = Invoice.create(customer_id: @customer_2.id, status: 'completed')
      @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_1.id)
      @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_1.id)
      @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 5, unit_price: 1200, status: "pending")
      @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 4, unit_price: 1200, status: "packaged")
      @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 1200, status: "shipped")
      @invoice_item_4 = InvoiceItem.create!(item: @item_3, invoice: @invoice_2, quantity: 3, unit_price: 1200, status: "shipped")
    end
  end
end
