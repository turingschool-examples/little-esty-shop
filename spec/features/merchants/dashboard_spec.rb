require 'rails_helper'

RSpec.describe 'Merchant Dashboard' , type: :feature do
  before do
    @merchant = create :merchant
    @item1 = create :item, { merchant_id: @merchant.id}
    @item2 = create :item, { merchant_id: @merchant.id}
    @item3 = create :item, { merchant_id: @merchant.id}

    @customer = create :customer
    @invoice1 = create :invoice, { customer_id: @customer.id}
    @invoice2 = create :invoice, { customer_id: @customer.id}


    visit merchant_dashboard_index_path(@merchant)
  end

  describe 'display' do
    it 'displays merchant name' do
      expect(page).to have_content(@merchant.name)
    end

    it 'has a link to view all merchant items' do
      expect(page).to have_link("Merchant Items")

      click_link
      expect(current_path).to eq(merchant_items_path(@merchant))
    end

    it 'has a link to view all merchant invoices' do
      expect(page).to have_link("Merchant Invoices")

      click_link
      expect(current_path).to eq(merchant_invoices_path(@merchant))
    end
  end
end