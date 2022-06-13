require 'rails_helper'

RSpec.describe 'The Merchant Invoices Index' do
  before :each do
    @merchant = Merchant.create!(name: 'The Duke')
    @customer1 = Customer.create!(first_name: 'Tired', last_name: 'Person')
    @invoice1 = Invoice.create!(status: 0, customer_id: @customer1.id)
    @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @merchant.id)
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100,
                                         status: 1)
  end
  it 'displays all invoices that include a merchants items' do
    visit merchant_invoices_path(@merchant.id)
    expect(page).to have_content('Merchant Invoices Index')
    expect(page).to have_content("Invoice Id: #{@invoice1.id}")
  end
  it 'displays invoices as clickable links that bring the user to the merchant invoice show page' do
    visit merchant_invoices_path(@merchant.id)
    click_link("#{@invoice1.id}")
    expect(current_path).to eq(merchant_invoice_path(@merchant.id, @invoice1.id))
  end
end
