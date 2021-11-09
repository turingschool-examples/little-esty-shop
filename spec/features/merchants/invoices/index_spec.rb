require 'rails_helper'

RSpec.describe 'merchants invoices index page' do
  before do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create :item, { merchant_id: @merchant1.id }
    @item2 = create :item, { merchant_id: @merchant1.id }
    @item3 = create :item, { merchant_id: @merchant2.id }

    @customer1 = create :customer

    @invoice1 = create :invoice, { customer_id: @customer1.id }
    @invoice2 = create :invoice, { customer_id: @customer1.id }

    @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
    @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }

    @inv_item1 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice1.id}
    @inv_item2 = create :invoice_item, { item_id: @item2.id, invoice_id: @invoice2.id}
    @inv_item3 = create :invoice_item, { item_id: @item3.id, invoice_id: @invoice2.id}

    visit merchant_invoices_path(@merchant1)
  end

  it 'when i visit merchant invoices index' do
    expect(current_path).to eq(merchant_invoices_path(@merchant1))
  end

  it 'i see all invoices that include at least one of merchants items' do
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
  end

  it 'each id links to the merchant invoice show page' do
    within("#invoice-#{@invoice1.id}") do
      click_link @invoice1.id
      expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice1))
    end
  end
end
