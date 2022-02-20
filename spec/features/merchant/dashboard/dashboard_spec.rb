require 'rails_helper'

RSpec.describe 'The Merchant Dashboard' do
  before :each do
    @katz = Merchant.create!(name: 'Katz Kreations')
    @mrpickles = Customer.create!(first_name: 'Mr', last_name: 'Pickles')
    @invoice1 =Invoice.create!(status: 0, customer_id: @mrpickles.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @katz.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
  end

  it "displays the merchant's name" do
    visit "/merchants/#{@katz.id}/dashboard"
    expect(page).to have_content(@katz.name)
  end
end
