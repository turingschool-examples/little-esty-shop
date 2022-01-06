require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}

  let!(:item_1) {merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50, status: 'enabled')}
  let!(:item_2) {merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100, status: 'enabled')}
  let!(:item_3) {merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50, status: 'enabled')}
  let!(:item_4) {merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50, status: 'enabled')}
  let!(:item_5) {merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50, status: 'disabled')}
  let!(:item_6) {merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50, status: 'disabled')}


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

  let!(:transaction_1) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_4) {invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_5) {invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_6) {invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')}

  let!(:transaction_7) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}
  let!(:transaction_8) {invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')}

  let!(:invoice_item_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 50, status: 'shipped')}
  let!(:invoice_item_2) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 2, unit_price: 50, status: 'packaged')}
  let!(:invoice_item_3) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 3, unit_price: 50, status: 'pending', created_at: Time.new(2021))}
  let!(:invoice_item_4) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 4, unit_price: 50, status: 'pending', created_at: Time.new(2020))}
  let!(:invoice_item_5) {InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 5, unit_price: 50, status: 'pending', created_at: Time.new(2019))}
  let!(:invoice_item_6) {InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 6, unit_price: 50, status: 'pending', created_at: Time.new(2018))}

  before(:each) do
    visit "/merchants/#{merchant_1.id}/items"
  end

  it 'lists names of all items for merchant' do
    expect(page).to have_content("Obsidian Nobice")
    expect(page).to have_content("Pleasure Geode")
  end

  it 'doesnt list items from other merchants' do
    expect(page).to_not have_content("Fridge")
  end

  it 'can disable or enable item' do
    expect(page).to have_button("Enable")
    expect(page).to have_button("Disable")
  end

  it 'item is disabled by default' do
    expect(page).to have_content('Healing Crystal (disabled)')
  end

  it 'can update status of item' do
    click_button("Enable", id: item_6.id)
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
    expect(page).to have_content('Healing Crystal (enabled)')
  end

  it 'displays only enabled items under enabled section and disabled items under disabled section' do

    within "#enabled" do
      expect(page).to have_content('Obsidian Nobice')
      expect(page).to have_content('Pleasure Geode')
      expect(page).to have_content('Brown Pebble')
      expect(page).to have_content('Red Rock')
      expect(page).to_not have_content('Solid Limestone')
      expect(page).to_not have_content('Healing Crystal')
    end
    within "#disabled" do
      expect(page).to_not have_content('Obsidian Nobice')
      expect(page).to_not have_content('Pleasure Geode')
      expect(page).to_not have_content('Brown Pebble')
      expect(page).to_not have_content('Red Rock')
      expect(page).to have_content('Solid Limestone')
      expect(page).to have_content('Healing Crystal')
    end

  end

  it 'When the Create Item link is clicked, it takes you to correct route' do
    click_link("Create Item")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")
  end

  it 'displays the top 5 items by revenue generated' do
    within "#top-5-items" do
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_4.name)
      expect(page).to have_content(item_5.name)
      expect(page).to have_content(item_6.name)
      expect(page).to_not have_content(item_1.name)
    end
  end

  it 'each top 5 item name links to its show page' do
    within "#top-5-items" do
      expect(page).to have_link(item_2.name)
      expect(page).to have_link(item_3.name)
      expect(page).to have_link(item_4.name)
      expect(page).to have_link(item_5.name)
      expect(page).to have_link(item_6.name)
      expect(page).to_not have_link(item_1.name)
    end
  end

  it 'each item in the top 5 displays the total revenue generated next to its name' do
    within "#top-5-items" do
      expect(page).to have_content("#{item_2.name}, Revenue: $100")
      expect(page).to have_content("#{item_3.name}, Revenue: $150")
      expect(page).to have_content("#{item_4.name}, Revenue: $200")
      expect(page).to have_content("#{item_5.name}, Revenue: $250")
      expect(page).to have_content("#{item_6.name}, Revenue: $300")
      expect(page).to_not have_content("#{item_1.name}, Revenue: $50")
    end
  end

  it 'displays the top selling date next to each top 5 item' do
    within "#top-5-items" do
      expect(page).to have_content("#{item_2.name}, Revenue: $100, Best Date: #{item_2.best_selling_date}")
      expect(page).to have_content("#{item_3.name}, Revenue: $150, Best Date: #{item_3.best_selling_date}")
      expect(page).to have_content("#{item_4.name}, Revenue: $200, Best Date: #{item_4.best_selling_date}")
      expect(page).to have_content("#{item_5.name}, Revenue: $250, Best Date: #{item_5.best_selling_date}")
      expect(page).to have_content("#{item_6.name}, Revenue: $300, Best Date: #{item_6.best_selling_date}")
    end
  end

end
