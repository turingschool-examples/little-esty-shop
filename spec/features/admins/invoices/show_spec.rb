require 'rails_helper'

RSpec.describe 'admin invoices show' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")

    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
    @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
    @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
    @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
    @customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
    @customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_7 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_8 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_9 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_10 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_11 = Invoice.create!(status: 1, customer_id: @customer_5.id)
    @invoice_12 = Invoice.create!(status: 1, customer_id: @customer_6.id)
    @invoice_13 = Invoice.create!(status: 1, customer_id: @customer_6.id)

    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)

    @ii_1 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
    @ii_3 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
    @ii_4 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
    @ii_5 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
    @ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
    
    @transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_6.id)
    @transaction_7 = Transaction.create!(credit_card_number: "4654407418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_7.id)
    @transaction_8 = Transaction.create!(credit_card_number: "4653405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_8.id)
    @transaction_9 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_9.id)
    @transaction_10 = Transaction.create!(credit_card_number: "4654435418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_10.id)
    @transaction_11 = Transaction.create!(credit_card_number: "4654405418259638", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_11.id)
    @transaction_12 = Transaction.create!(credit_card_number: "4654405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_12.id)
    @transaction_13 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_13.id)
  end

  it 'contains an invoice\'s ID, status, created_at date, customer first/last name' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Invoice status: #{@invoice_1.status}")
    expect(page).to have_content("Created at: #{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("Customer name: #{@customer_1.first_name} #{@customer_1.last_name}")
  end

  it 'contains item name, quantity of item ordered, price item sold for, invoice item status' do
    visit admin_invoice_path(@invoice_1)

    within("#item-#{@ii_1.id}") do
      expect(page).to have_content("Item Name: #{@item_1.name}")
      expect(page).to have_content("Quantity: #{@ii_1.quantity}")
      expect(page).to have_content("Price: #{@ii_1.unit_price}")
      expect(page).to have_content("Status: #{@ii_1.status}")
    end
  end

  it ' displays the total revenue that will be generated from this invoice' do
    visit admin_invoice_path(@invoice_1)

    within("#total_revenue") do
      expect(page).to have_content("Total Revenue: #{@invoice_1.calculate_total_revenue}")
    end
  end
end