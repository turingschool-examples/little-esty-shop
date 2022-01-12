require 'rails_helper'

RSpec.describe 'Admin merchant index page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks', status: 'enabled')}
  let!(:merchant_2) {Merchant.create!(name: 'Dylans harps', status: 'enabled')}
  let!(:merchant_3) {Merchant.create!(name: 'Croixs Roids', status: 'enabled')}
  let!(:merchant_4) {Merchant.create!(name: 'Chris Ice Picks', status: 'disabled')}
  let!(:merchant_5) {Merchant.create!(name: 'Jacksons Merry Wreaths', status: 'disabled')}
  let!(:merchant_6) {Merchant.create!(name: 'Mikes Fresh Pike', status: 'disabled')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50)}
  let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50)}
  let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50)}
  let!(:item_6) {merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50)}

  let!(:item_7) {merchant_2.items.create!(name: 'Green Rock', description: 'A big green rock', unit_price: 50)}
  let!(:item_8) {merchant_2.items.create!(name: 'Colorado Sandstone', description: 'crumbly', unit_price: 50)}
  let!(:item_9) {merchant_2.items.create!(name: 'Salt Lick', description: 'delicious', unit_price: 50)}


  let!(:customer_1) {Customer.create!(first_name: 'Billy', last_name: 'Carruthers')}
  let!(:customer_2) {Customer.create!(first_name: 'Dave', last_name: 'King')}
  let!(:customer_3) {Customer.create!(first_name: 'Reid', last_name: 'Anderson')}
  let!(:customer_4) {Customer.create!(first_name: 'Elvind', last_name: 'Opsvik')}
  let!(:customer_5) {Customer.create!(first_name: 'Ethan', last_name: 'Iverson')}
  let!(:customer_6) {Customer.create!(first_name: 'Chris', last_name: 'Speed')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 'completed' )}
  let!(:invoice_2) {customer_2.invoices.create!(status: 'completed' )}
  let!(:invoice_3) {customer_3.invoices.create!(status: 'completed' )}
  let!(:invoice_4) {customer_4.invoices.create!(status: 'completed' )}
  let!(:invoice_5) {customer_5.invoices.create!(status: 'completed' )}
  let!(:invoice_6) {customer_6.invoices.create!(status: 'completed' )}


  #Billy
  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_7) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_8) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Dave, Reid, Elvind
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  #Ethan
  let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_9) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_10) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}
  let!(:transaction_11) {invoice_5.transactions.create!(credit_card_number: '4234123412341234', credit_card_expiration_date: '12/22', result: 'success')}

  #Chris
  let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 3, unit_price: 100, status: 'shipped')}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'packaged')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
  let!(:invoice_item_7) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 50, status: 'shipped', created_at: Time.new(2018))}

  let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 100, status: 'pending', created_at: Time.new(2019))}
  let!(:invoice_item_6) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))}

   let!(:invoice_item_8) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_7.id, quantity: 1, unit_price: 50, status: 'shipped', created_at: Time.new(2018))}
   let!(:invoice_item_9) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_8.id, quantity: 1, unit_price: 100, status: 'pending', created_at: Time.new(2019))}
   let!(:invoice_item_10) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_9.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))}





  it 'has the name of each merchant in the system' do
    visit '/admin/merchants'
    expect(page).to have_link("#{merchant_1.name}")
    expect(page).to have_link("#{merchant_2.name}")
    expect(page).to have_link("#{merchant_3.name}")
    expect(page).to have_link("#{merchant_4.name}")
    expect(page).to have_link("#{merchant_5.name}")
  end

  it 'has button to enable merchant, if disabled' do
    visit '/admin/merchants'
    expect(page).to have_button("Enable Chris Ice Picks")
    expect(page).to have_button("Enable Jacksons Merry Wreaths")
    expect(page).to have_button("Enable Mikes Fresh Pike")
  end

  it 'has button to disable merchant, if enabled' do
    visit '/admin/merchants'
    expect(page).to have_button("Disable Billys Pet Rocks")
    expect(page).to have_button("Disable Dylans harps")
    expect(page).to have_button("Disable Croixs Roids")
  end

  it 'enables merchant when button is clicked' do
    visit '/admin/merchants'
    click_button("Enable Chris Ice Picks")
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_button("Disable Chris Ice Picks")
    expect(page).to_not have_button("Enable Chris Ice Picks")
  end

  it 'disables merchant when button is clicked' do
    visit '/admin/merchants'
    click_button("Disable Dylans harps")
    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_button("Enable Dylans harps")
    expect(page).to_not have_button("Disable Dylans harps")
    # expect(merchant_2.status).to eq("disabled")
  end

  it 'separates enabled and disabled' do
    visit '/admin/merchants'

    within "#enabled" do
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content(merchant_3.name)


      expect(page).to_not have_content(merchant_4.name)
      expect(page).to_not have_content(merchant_5.name)
      expect(page).to_not have_content(merchant_6.name)
    end
    within "#disabled" do
      expect(page).to have_content(merchant_4.name)
      expect(page).to have_content(merchant_5.name)
      save_and_open_page
      expect(page).to have_content(merchant_6.name)

      expect(page).to_not have_content(merchant_1.name)
      expect(page).to_not have_content(merchant_2.name)
      expect(page).to_not have_content(merchant_3.name)

    end
  end

  it 'has link to create new merchant' do
    visit '/admin/merchants'
    expect(page).to have_link("Create new merchant")
  end

  it 'creates new merchant when link is clicked' do
    visit '/admin/merchants'
    click_link 'Create new merchant'
    expect(current_path).to eq("/admin/merchants/new")
    fill_in(:name, with: "Dylan's harps")
    click_button("Create merchant")
    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Dylan's harps")
    expect(page).to have_button("Enable Dylan's harps")
  end

  it "has the top 5 merchants displayed and their total revenue" do
    visit '/admin/merchants'
    within "#top_5_merchants" do


    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_1.total_revenue)
    expect(page).to have_content(merchant_2.total_revenue)
    end

  end





end
