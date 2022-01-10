require 'rails_helper'

describe 'merchant invoices index' do
  before do
    @merchant = create :merchant
    @merchant2 = create :merchant

    @customer = create :customer

    @invoice1 = create :invoice, { customer_id: @customer.id }
    @invoice2 = create :invoice, { customer_id: @customer.id }
    @invoice3 = create :invoice, { customer_id: @customer.id }

    @item1 = create :item, { merchant_id: @merchant.id, status: 'Enabled' }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item, { merchant_id: @merchant2.id }

    @invoice_item1 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item1.id, unit_price: 50, quantity: 1 }
    @invoice_item2 = create :invoice_item, { invoice_id: @invoice2.id, item_id: @item2.id, unit_price: 100, quantity: 1 }
    @invoice_item3 = create :invoice_item, { invoice_id: @invoice3.id, item_id: @item3.id, unit_price: 200, quantity: 1 }

    visit merchant_invoices_path(@merchant)
  end

  describe 'display' do
    it 'all invoices with IDs' do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
      expect(page).to_not have_content(@invoice3.id)
    end

    it 'ID links to invoice show page' do
      click_link @invoice1.id
      expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))
    end
  end
end