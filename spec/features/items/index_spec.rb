require 'rails_helper'

RSpec.describe "item index page" do
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
    @customer_8 = Customer.create!(first_name: "Goofy", last_name: "Dog")

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
    @invoice_14 = Invoice.create!(status: 1, customer_id: @customer_8.id)
    @invoice_15 = Invoice.create!(status: 1, customer_id: @customer_8.id)
    @invoice_16 = Invoice.create!(status: 1, customer_id: @customer_8.id)
    @invoice_17 = Invoice.create!(status: 1, customer_id: @customer_8.id)
    @invoice_18 = Invoice.create!(status: 1, customer_id: @customer_8.id)

    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)
    @item_3 = Item.create!(name: "Digimon Cards", description: "What are these again?", unit_price: 300, merchant_id: @merchant_1.id, status: 1)
    @item_4 = Item.create!(name: "Magic 8 Ball", description: "Fortune Telling", unit_price: 2000, merchant_id: @merchant_1.id, status: 1)
    @item_5 = Item.create!(name: "Stretch Armstrong", description: "Stretchy", unit_price: 100, merchant_id: @merchant_1.id, status: 1)
    @item_6 = Item.create!(name: "Yu-Gi-Oh Cards", description: "It's time to duel", unit_price: 1000, merchant_id: @merchant_1.id, status: 1)
    @item_7 = Item.create!(name: "Barbie Dream House", description: "Barbie Time", unit_price: 4000, merchant_id: @merchant_1.id, status: 1)

    @ii_1 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
    @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
    @ii_3 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
    @ii_4 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
    @ii_5 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
    @ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
    @ii_7 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_7.id)
    @ii_8 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_8.id)
    @ii_9 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_9.id)
    @ii_10 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_10.id)
    @ii_11 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_11.id)
    @ii_12 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_12.id)
    @ii_13 = InvoiceItem.create!(quantity: 5, unit_price: 3500, status: "shipped", item_id: @item_3.id, invoice_id: @invoice_13.id)
    @ii_14 = InvoiceItem.create!(quantity: 5, unit_price: 4500, status: "shipped", item_id: @item_4.id, invoice_id: @invoice_14.id)
    @ii_15 = InvoiceItem.create!(quantity: 5, unit_price: 6500, status: "shipped", item_id: @item_5.id, invoice_id: @invoice_15.id)
    @ii_16 = InvoiceItem.create!(quantity: 5, unit_price: 5500, status: "shipped", item_id: @item_6.id, invoice_id: @invoice_16.id)
    @ii_17 = InvoiceItem.create!(quantity: 5, unit_price: 7500, status: "shipped", item_id: @item_7.id, invoice_id: @invoice_17.id)
    @ii_18 = InvoiceItem.create!(quantity: 5, unit_price: 7500, status: "shipped", item_id: @item_7.id, invoice_id: @invoice_18.id)
  
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
    @transaction_14 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_14.id)
    @transaction_15 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_15.id)
    @transaction_16 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_16.id)
    @transaction_17 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_17.id)
    @transaction_18 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_18.id)
  end

  it 'has a list of all a specific merchants items' do
    visit "/merchants/#{@merchant_1.id}/items"
    
    @merchant_1.items.each do |item|
      expect(page).to have_content(item.name)
    end

    @merchant_2.items.each do |item|
      expect(page).to_not have_content(item.name)
    end
  end

  it 'has a button to disable or enable that item' do
    visit "/merchants/#{@merchant_1.id}/items"

    within("#item_#{@item_1.id}") do
      expect(page).to have_button 'Enable'
      expect(page).to_not have_button 'Disable'
    end
    
    click_button 'Enable'
    
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    
    within("#item_#{@item_1.id}") do
      expect(page).to_not have_button 'Enable'
      expect(page).to have_button 'Disable'
      
      click_button 'Disable'
    end
    
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it 'displays an items current status' do
    visit "/merchants/#{@merchant_1.id}/items"

    within("#item_#{@item_1.id}") do
      expect(page).to have_content(@item_1.status)
    end
  end

  it 'has a seperate section for Enabled and Disabled' do
    visit "/merchants/#{@merchant_1.id}/items"
    
    within("#disabled") do
      expect(page).to have_content('Disabled Items')
      expect(page).to have_content(@item_1.name)
      expect(page).to_not have_content(@item_3.name)
    end

    within("#enabled") do
      expect(page).to have_content('Enabled Items')
      expect(page).to have_content(@item_3.name)
      expect(page).to_not have_content(@item_1.name)
    end
  end

  it 'top 5 items by revenue' do
    visit "/merchants/#{@merchant_1.id}/items"

    within("#top_5_revenue") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_7.name)
      expect(page).to have_content(@item_6.name)
      expect(page).to have_content(@item_5.name)
      expect(page).to have_content(@item_4.name)

      expect(@item_1.name).to appear_before(@item_7.name)
      expect(@item_7.name).to appear_before(@item_5.name)
      expect(@item_5.name).to appear_before(@item_6.name)
      expect(@item_6.name).to appear_before(@item_4.name)
    end
  end

  it 'has link to each merchant item show page' do
    visit "/merchants/#{@merchant_1.id}/items"

    within("#top_5_revenue") do
      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_7.name)
      expect(page).to have_link(@item_6.name)
      expect(page).to have_link(@item_5.name)
      expect(page).to have_link(@item_4.name)
    end
  end

  it 'has the total revenue generated next to each item' do
    visit "/merchants/#{@merchant_1.id}/items"

    within("#top_5_revenue") do
      expect(page).to have_content("$2080.00")
      expect(page).to have_content("$750.00")
      expect(page).to have_content("$325.00")
      expect(page).to have_content("$275.00")
      expect(page).to have_content("$225.00")
      # expect(page).to have_content(@merchant_1.top_five_items_by_revenue[0].item_revenue)
      # expect(page).to have_content(@merchant_1.top_five_items_by_revenue[1].item_revenue)
      # expect(page).to have_content(@merchant_1.top_five_items_by_revenue[2].item_revenue)
      # expect(page).to have_content(@merchant_1.top_five_items_by_revenue[3].item_revenue)
      # expect(page).to have_content(@merchant_1.top_five_items_by_revenue[4].item_revenue)
    end
  end

  it ' displays the date with the most sales next to each of the 5 most pop items' do
    visit "/merchants/#{@merchant_1.id}/items"

    within("#top_5_revenue") do
      expect(page).to have_content(@item_1.created_at)
      expect(page).to have_content(@item_7.created_at)
      expect(page).to have_content(@item_4.created_at)
      expect(page).to have_content(@item_5.created_at)
      expect(page).to have_content(@item_6.created_at)
    end
  end
end