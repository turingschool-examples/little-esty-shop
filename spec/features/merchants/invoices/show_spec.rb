require 'rails_helper'

RSpec.describe 'merchant invoice show page' do
  before do
    @merchant = create(:merchant)

    @item = create :item, { merchant_id: @merchant.id }

    @customer = create :customer

    @invoice = create :invoice, { customer_id: @customer.id }

    @transaction = create :transaction, { invoice_id: @invoice.id, result: 'success' }

    @inv_item = create :invoice_item, { item_id: @item.id, invoice_id: @invoice.id}

    visit merchant_invoice_path(@merchant, @invoice)
  end

  it 'when i visit merchant invoice show page' do
    expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice))
  end

  it 'i see invoice id, status, created_at formatted, and customer first and last' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.status)
    expect(page).to have_content(@invoice.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@invoice.customer.full_name)
  end
end

# Then I see information related to that invoice including:
# - Invoice id
# - Invoice status
# - Invoice created_at date in the format "Monday, July 8, 209"
# - Customer first and last name
