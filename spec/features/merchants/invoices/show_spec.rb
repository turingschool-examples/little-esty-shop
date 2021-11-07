require 'rails_helper'

RSpec.describe 'merchant invoice show page' do
  before do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create :item, { merchant_id: @merchant1.id }
    @item2 = create :item, { merchant_id: @merchant1.id }
    @item3 = create :item, { merchant_id: @merchant2.id }

    @customer = create :customer

    @invoice = create :invoice, { customer_id: @customer.id }

    @transaction = create :transaction, { invoice_id: @invoice.id, result: 'success' }

    @inv_item1 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice.id}
    @inv_item2 = create :invoice_item, { item_id: @item2.id, invoice_id: @invoice.id}
    @inv_item3 = create :invoice_item, { item_id: @item3.id, invoice_id: @invoice.id}

    visit merchant_invoice_path(@merchant1, @invoice)
  end

  it 'when i visit merchant invoice show page' do
    expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice))
  end

  it 'i see invoice id, status, created_at formatted, and customer first and last' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@invoice.customer.full_name)
  end

  it 'i see all the items on the invoice with name, quantity, sell price and inv_item status only for this merchant' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.invoice_items.first.quantity)
    expect(page).to have_content(@item1.invoice_items.first.unit_price.fdiv(100))
    expect(page).to have_content(@item1.invoice_items.first.status)
    expect(page).to have_content(@item2.name)
    expect(page).to_not have_content(@item3.name)
  end
end
