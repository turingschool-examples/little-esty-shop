require 'rails_helper'

RSpec.describe "merchant dashboard" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")

    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
    @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
    @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
    @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
    @customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
    @customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")
    @customer_7 = Customer.create!(first_name: "Donald", last_name: "Duck")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_6.id)
    @invoice_7 = Invoice.create!(status: 1, customer_id: @customer_7.id)
    @invoice_8 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_9 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_10 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_11 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_12 = Invoice.create!(status: 1, customer_id: @customer_4.id)
    @invoice_13 = Invoice.create!(status: 1, customer_id: @customer_5.id)

    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)

    InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
    InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
    InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
    InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
    InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
    InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_7.id)
    InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_8.id)
    InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_9.id)
    InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_10.id)
    InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_11.id)
    InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_12.id)
    InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_13.id)
    
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
    @transaction_11 = Transaction.create!(credit_card_number: "4654405418259638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_11.id)
    @transaction_12 = Transaction.create!(credit_card_number: "4654405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_12.id)
    @transaction_13 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_13.id)
  end

  it 'will show the name of the merchant' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/dashboard")
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it 'will have a link to the merchant item index' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("My Items")

    click_link "My Items"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it 'will have a link to my merchant invoices index' do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("My Invoices")

    click_link "My Invoices"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
  end

  it 'will list the top 5 customers for this merchant' do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    
    within("#top_customers") do
      expect(@customer_2.first_name).to appear_before(@customer_1.first_name)
      expect(@customer_1.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
      expect(@customer_4.first_name).to appear_before(@customer_7.first_name)
      expect(@customer_7.first_name).to_not appear_before(@customer_2.first_name)
      expect(page).to_not have_content(@customer_6.first_name) 
    end
  end

  it 'has the number of successful transactions with the merchant next to each customer' do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    within('#top_customers') do
      expect(page).to have_content("#{@customer_2.first_name} - Successful Transactions: 9")
      expect(page).to have_content("#{@customer_1.first_name} - Successful Transactions: 4")
      expect(page).to have_content("#{@customer_3.first_name} - Successful Transactions: 2")
      expect(page).to have_content("#{@customer_4.first_name} - Successful Transactions: 1")
      expect(page).to have_content("#{@customer_7.first_name} - Successful Transactions: 1")
    end
  end
# As a merchant
# When I visit my merchant dashboard
# Then I see a section for "Items Ready to Ship"
# In that section I see a list of the names of all of my items that
# have been ordered and have not yet been shipped,
# And next to each Item I see the id of the invoice that ordered my item
# And each invoice id is a link to my merchant's invoice show page
  describe "items ready to ship" do
    it 'has a list of items that have not yet been shipped' do
      visit "/merchants/#{@merchant_1.id}/dashboard"
save_and_open_page
      within('#items_ready_to_ship') do
        expect(page).to have_content("Items ready to ship")
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_3.id)
        expect(page).to have_content(@invoice_7.id)
        expect(page).to have_content(@invoice_9.id)
        expect(page).to_not have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_4.id)
      end

      # it 'has the id as a link' do
      #   visit "/merchants/#{@merchant_1.id}/dashboard"

      #   within('#items_ready_to_ship') do
      #     expect(page).to have_link(@invoice_1.id)
      #     expect(page).to have_link(@invoice_3.id)
      #     expect(page).to have_link(@invoice_7.id)
      #     expect(page).to have_link(@invoice_9.id)
      #     expect(page).to_not have_link(@invoice_2.id)
      #     expect(page).to_not have_link(@invoice_4.id)
      #   end
      #   click_link (@invoice_2.id)

      #   expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_2.id}")
      # end
    end
  end
end