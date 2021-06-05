require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page' do
  before :each do
    @customer_1 = Customer.create!(first_name: 'Jerry', last_name: 'Cantrell')

    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_4 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_5 = Invoice.create!(status: 0, customer_id: @customer_1.id)

    @merchant_1 = Merchant.create!(name: 'Roald', status: 'enable')
    @merchant_2 = Merchant.create!(name: 'Marshall', status: 'disable')
    @merchant_3 = Merchant.create!(name: 'Big Rick', status: 'enable')
    @merchant_4 = Merchant.create!(name: 'Debby', status: 'disable')
    @merchant_5 = Merchant.create!(name: 'Linda', status: 'enable')
    @merchant_6 = Merchant.create!(name: 'Roswell',status: 'disable')

    @trasaction_1 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_1.id)
    @trasaction_2 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_2.id)
    @trasaction_3 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_3.id)
    @trasaction_4 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_4.id)
    @trasaction_5 = Transaction.create!(credit_card_number: '1928333429810', credit_card_expiration_date: '1121', result: 0, invoice_id: @invoice_5.id)

    @item_1 = @merchant_1.items.create!(name: 'Funyuns', description: 'Tasty', unit_price: 100)
    @item_2 = @merchant_2.items.create!(name: 'Doritos', description: 'Delicious', unit_price: 100)
    @item_3 = @merchant_3.items.create!(name: 'Peanut M&Ms', description: 'Tasty', unit_price: 100)
    @item_4 = @merchant_4.items.create!(name: 'Kit-Kat', description: 'Tasty', unit_price: 100)
    @item_5 = @merchant_5.items.create!(name: 'Burritos', description: 'Tasty', unit_price: 100)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id , invoice_id: @invoice_1.id, quantity: 100, unit_price: 10, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id , invoice_id: @invoice_2.id, quantity: 200, unit_price: 10, status: 0)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id , invoice_id: @invoice_3.id, quantity: 300, unit_price: 10, status: 0)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id , invoice_id: @invoice_4.id, quantity: 400, unit_price: 10, status: 0)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id , invoice_id: @invoice_5.id, quantity: 500, unit_price: 10, status: 0)

    visit '/admin/merchants'
  end

  it 'has each name as a link' do
    within('#enabled_merchants') do

      click_on "#{@merchant_1.name}"

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end
  end

  it 'shows the name on the merchants show page' do
    visit "/admin/merchants/#{@merchant_1.id}"

    expect(page).to have_content(@merchant_1.name)
  end
end
