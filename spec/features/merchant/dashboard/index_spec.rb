require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do

     @merchant1 = Merchant.create!(name: 'Chuckin Pucks')
     @customer = Customer.create!(first_name: 'Samantha', last_name: 'Ore')
     @customer_2 = Customer.create!(first_name: 'Jake', last_name: 'Statefarm')
     @customer_3 = Customer.create!(first_name: 'Harry', last_name: 'Potter')
     @customer_4 = Customer.create!(first_name: 'Lloyd', last_name: 'Christmas')
     @customer_5 = Customer.create!(first_name: 'Fettucine', last_name: 'Alfredo')
     @customer_6 = Customer.create!(first_name: 'Bob', last_name: 'Builder')
     @invoice_1 = Invoice.create!(customer_id: @customer.id, status: 2)
     @invoice_1a = Invoice.create!(customer_id: @customer.id, status: 2)
     @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 2)
     @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 2)
     @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 2)
     @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 2)
     @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 2)

     @item_1 = Item.create!(name: "Shampoo", description: "Cleans the lettuce", unit_price: 5, merchant_id: @merchant1.id)

     @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
     @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1a.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
     @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
     @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
     @ii_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
     @ii_6 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")
     @ii_7 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
     @ii_8 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-29 14:54:09")

     @transaction1 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_1.id)
     @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_1a.id)
     @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_2.id)
     @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_3.id)
     @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_4.id)
     @transaction2 = Transaction.create!(credit_card_number: 203942, result: "success", invoice_id: @invoice_5.id)
  end

   it "displays merchant name" do
    merchant = Merchant.create!(name: "Schroeder-Jerde")
    merchant2 = Merchant.create!(name: "Klein, Rempel and Jones")
    visit "/merchant/#{merchant.id}/dashboard"
    expect(page).to have_content(merchant.name)
    expect(page).to_not have_content(merchant2.name)
   end

   it "displays link to merchant items and invoices" do
    merchant = Merchant.create!(name: "Schroeder-Jerde")
    visit "/merchant/#{merchant.id}/dashboard"
    expect(page).to have_link("Items")
    expect(page).to have_link("Invoices")
   end

   it "should display names of the top 5 customers" do
     visit "/merchant/#{@merchant1.id}/dashboard"
     save_and_open_page
     expect(page).to have_content(@customer.first_name)
     expect(page).to have_content(@customer.last_name)
     expect(page).to_not have_content(@customer_6.first_name)
     expect(page).to_not have_content(@customer_6.last_name)
     expect(page).to have_content("Samantha Ore - 6 purchases")
     expect(page).to_not have_content("Bob Builder - 6 purchases")
   end
end
