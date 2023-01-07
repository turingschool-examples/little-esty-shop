require 'rails_helper'

RSpec.describe 'admin merchants index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy", status: "enabled")
    @merchant_2 = Merchant.create!(name: "Different Guy")
    @merchant_3 = Merchant.create!(name: "Christian")
    @merchant_4 = Merchant.create!(name: "Braxton")
    @merchant_5 = Merchant.create!(name: "Alastair")
    @merchant_6 = Merchant.create!(name: "Anthony")

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
    @item_3 = Item.create!(name: "Digimon Cards", description: "What are these again?", unit_price: 300, merchant_id: @merchant_3.id, status: 1)
    @item_4 = Item.create!(name: "Magic 8 Ball", description: "Fortune Telling", unit_price: 2000, merchant_id: @merchant_4.id, status: 1)
    @item_5 = Item.create!(name: "Stretch Armstrong", description: "Stretchy", unit_price: 100, merchant_id: @merchant_5.id, status: 1)
    @item_6 = Item.create!(name: "Yu-Gi-Oh Cards", description: "It's time to duel", unit_price: 1000, merchant_id: @merchant_6.id, status: 1)

    InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id) # 20000
    InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_2.id) # 800
    InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_3.id, invoice_id: @invoice_3.id) # 3200
    InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_4.id, invoice_id: @invoice_4.id) # 80000
    InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_5.id, invoice_id: @invoice_5.id) # 500
    InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_6.id, invoice_id: @invoice_6.id) # 12500
    
    @transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_6.id)
  end

  it 'contains the name of each merchant in the system' do
    visit admin_merchants_path

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
  end

  # it 'links to a merchants show page' do
  #   visit admin_merchants_path

  #   expect(page).to have_link(@merchant_1.name)
  #   expect(page).to have_link(@merchant_2.name)

  #   click_link @merchant_1.name
    

  #   expect(current_path).to eq(admin_merchant_path(@merchant_1))

  #   expect(page).to have_content(@merchant_1.name)
  #   expect(page).to_not have_content(@merchant_2.name)
  # end

  it 'contains a button next to each merchants name to enable or disable that merchant' do
    visit admin_merchants_path

    within("#merchant_#{@merchant_2.id}") do
      expect(page).to have_content("Status: disabled")
      expect(page).to have_button 'Enable'
      expect(page).to_not have_button 'Disable'
      
      click_button 'Enable'
    end
    
    expect(current_path).to eq(admin_merchants_path)
    
    within("#merchant_#{@merchant_1.id}") do
      expect(page).to have_content("Status: enabled")
      expect(page).to_not have_button 'Enable'
      expect(page).to have_button 'Disable'
    end
  end

  it 'groups merchants by their status' do
    visit admin_merchants_path

    within("#disabled") do
      expect(page).to have_content('Disabled Merchants')
      expect(page).to have_content(@merchant_2.name)
      expect(page).to_not have_content(@merchant_1.name)
    end

    within("#enabled") do
      expect(page).to have_content('Enabled Merchants')
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end

  it 'has a link to create a new merchant' do
    visit admin_merchants_path
    expect(page).to have_link("Create New Merchant")
    click_link "Create New Merchant"
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it 'I see the names of the top 5 merchants by total revenue generated' do
    visit admin_merchants_path
    save_and_open_page
    within("#top_five_merchants") do
      expect(@merchant_4.name).to appear_before(@merchant_1.name)
      expect(@merchant_1.name).to appear_before(@merchant_6.name)
      expect(@merchant_6.name).to appear_before(@merchant_3.name)
      expect(@merchant_3.name).to appear_before(@merchant_2.name)
      expect(page).to_not have_content(@merchant_5.name)
    end
  end

  it 'And I see that each merchant name links to the admin merchant show page for that merchant' do
    visit admin_merchants_path

    within("#top_five_merchants") do
      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@merchant_2.name)
      expect(page).to have_link(@merchant_3.name)
      expect(page).to have_link(@merchant_4.name)
      expect(page).to have_link(@merchant_6.name)
      expect(page).to_not have_link(@merchant_5.name)

      click_link(@merchant_1.name)

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end
  end
end