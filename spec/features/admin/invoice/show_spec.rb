require 'rails_helper'

RSpec.describe 'Admin Invoice Show page' do
  before do
    @customer = Customer.create!(first_name: 'Bob', last_name: 'Dylan')
    @merchant = Merchant.create!(name: 'Jen')
    @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
    @item1 = Item.create!(name: 'Pumpkin', description: 'Orange', unit_price: 3, merchant_id: @merchant.id)
    @item2 = Item.create!(name: 'Pillow', description: 'Soft', unit_price: 20, merchant_id: @merchant.id)
    @invoice_item = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice.id, quantity: 10, unit_price: 30, status: 'shipped')
    @invoice_item = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice.id, quantity: 2, unit_price: 40, status: 'shipped')

    visit admin_invoices_show_path(@invoice.id)
  end
  it 'All the items on the invoice are shown' do
    expect(page).to have_content('Items:')

    within "#item-id-#{@item1.id}" do
      expect(page).to have_content('Item name: Pumpkin')
      expect(page).to have_content('Quantity of Pumpkin(s) ordered: 10')
      expect(page).to have_content('Total price of the Pumpkin(s): 30')
      expect(page).to have_content('Status: shipped')
    end

    within "#item-id-#{@item2.id}" do
      expect(page).to have_content('Item name: Pillow')
      expect(page).to have_content('Quantity of Pillow(s) ordered: 2')
      expect(page).to have_content('Total price of the Pillow(s): 40')
      expect(page).to have_content('Status: shipped')
    end
  end

  it 'shows the total revenue that will be generated from this invoice' do
    expect(page).to have_content('Total revenue expected: 70')
  end

  it 'can update the invoice status with a select field' do
    expect(page).to have_content('Invoice status is: completed')

    select "in progress", from: 'status'
    click_button 'Update Invoice Status'

    expect(current_path).to eq(admin_invoices_show_path(@invoice.id))
    expect(page).to have_content('Invoice status is: in progress')
  end
end
