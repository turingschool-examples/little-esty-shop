require 'rails_helper'

RSpec.describe 'admin dashboard' do

  before(:each) do
    @merchant = Merchant.create!(name: 'Brylan')
    @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 500, description: 'Writes things.')
    @item_2 = @merchant.items.create!(name: 'Pen', unit_price: 400, description: 'Writes things, but dark.')
    @item_3 = @merchant.items.create!(name: 'Marker', unit_price: 400, description: 'Writes things, but dark, and thicc.')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed')
    @invoice_7 = @customer_1.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-27 14:54:09 UTC"))
    @item_2.invoice_items.create!(invoice_id: @invoice_7.id, quantity: 5, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-28 14:54:09 UTC"))
    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')

    @customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
    @invoice_2 = @customer_2.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-29 14:54:09 UTC"))
    @invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249631', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')

    @customer_3 = Customer.create!(first_name: 'Toy', last_name: 'Mariah')
    @invoice_3 = @customer_3.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-03-30 14:54:09 UTC"))
    @invoice_3.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')

    @customer_4 = Customer.create!(first_name: 'Joy', last_name: 'Braun')
    @invoice_4 = @customer_4.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-01 14:54:09 UTC"))
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_5 = Customer.create!(first_name: 'Mark', last_name: 'Brains')
    @invoice_5 = @customer_5.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_5.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-02 14:54:09 UTC"))
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_6 = Customer.create!(first_name: 'Smark', last_name: 'Mrains')
    @invoice_6 = @customer_6.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_6.id, quantity: 3, unit_price: 400, status: 'packaged',
                                                                                       created_at: Time.parse("2012-04-03 14:54:09 UTC"))
    @invoice_6.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    visit "/admin"
  end

#   As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)

  it 'has links to the merchants index page' do
    expect(current_path).to eq('/admin')
    click_link 'Admin Merchants Index'
    expect(current_path).to eq('/admin/merchants')
  end

  it 'has links to the merchants invoice index page' do
    expect(current_path).to eq('/admin')
    click_link 'Admin Invoices Index'
    expect(current_path).to eq('/admin/invoices')
  end
end
