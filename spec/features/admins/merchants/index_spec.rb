require 'rails_helper'

RSpec.describe 'Merchant Index', type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Tillman Group', status: false)
    @merchant_2 = Merchant.create!(name: 'Kozy Group', status:true)
    @merchant_3 = Merchant.create!(name: 'K Group', status:true)
    @merchant_4 = Merchant.create!(name: 'O Group', status:true)
    @merchant_5 = Merchant.create!(name: 'Z Group', status:true)
    @merchant_6 = Merchant.create!(name: 'Y Group', status:true)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')

    @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}")
    @invoice_2 = Invoice.create!(status: 1, customer_id: "#{@customer_1.id}")
    @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}")
    @invoice_4 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}")
    @invoice_5 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}")
    @invoice_6 = Invoice.create!(status: 0, customer: @customer_1)

    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'success')
    @invoice_6.transactions.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: "", result: 'failed')

    @item_1 = @merchant_2.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_2 = @merchant_3.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_3 = @merchant_4.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_4 = @merchant_5.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_5 = @merchant_6.items.create!(name: 'item 1', description: 'item', unit_price: 1000)
    @item_6 = @merchant_1.items.create!(name: 'item 1', description: 'item', unit_price: 1000)

    InvoiceItem.create!(invoice: @invoice_1, item: @item_1, quantity: 5, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_2, item: @item_2, quantity: 4, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_3, item: @item_3, quantity: 3, unit_price: 1000, status: 1)
    InvoiceItem.create!(invoice: @invoice_4, item: @item_4, quantity: 2, unit_price: 1000, status: 0)
    InvoiceItem.create!(invoice: @invoice_5, item: @item_5, quantity: 1, unit_price: 1000, status: 2)
    InvoiceItem.create!(invoice: @invoice_6, item: @item_6, quantity: 5, unit_price: 1000, status: 2)

    visit admin_merchants_path
  end

  it 'displays the name of each merchant in the system' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
  end

  it 'has an enable button for each merchant to modify status to enabled' do
    within(:css, "##{@merchant_1.id}") do

      expect(page).to have_button("Enable")
    end
  end

  it 'has an disable button for each merchant to modify status to disabled' do #within block still finding duplicate buttons if status is the same
    within(:css, "##{@merchant_1.id}") do

      click_button 'Enable'

      expect(page).to have_button("Disable")
    end
  end

  it 'can group merchants by status' do #wrap both each blocks in a div to be able to test which merchants are appearing in each seciton

    expect(@merchant_1.name).to_not appear_before('Disabled Merchants')
    expect(@merchant_2.name).to appear_before('Disabled Merchants')
  end

  it 'can display the top five merchants by total revenue' do
    within(:css, "#top_five") do
      expect(page).to have_content('Top Five Merchants By Revenue')
      expect(@merchant_2.name).to appear_before(@merchant_3.name)
      expect(@merchant_3.name).to appear_before(@merchant_4.name)
      expect(@merchant_4.name).to appear_before(@merchant_5.name)
      expect(@merchant_5.name).to appear_before(@merchant_6.name)
      expect(page).to_not have_content(@merchant_1.name)
    end
  end
end
