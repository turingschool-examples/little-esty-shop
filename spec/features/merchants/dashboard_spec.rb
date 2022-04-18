require "rails_helper"

RSpec.describe "Merchant Dashboard", type: :feature do
  before do
    @merchant = create :merchant
    @item1 = create :item, {merchant_id: @merchant.id}
    @item2 = create :item, {merchant_id: @merchant.id}
    @item3 = create :item, {merchant_id: @merchant.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}

    visit merchant_dashboard_index_path(@merchant)
  end

  describe "display" do
    it "displays merchant name", :vcr do
      expect(page).to have_content(@merchant.name)
    end

    it "has a link to view all merchant items", :vcr do
      expect(page).to have_link("Merchant Items")

      click_link "Merchant Items"
      expect(current_path).to eq(merchant_items_path(@merchant))
    end

    it "has a link to view all merchant invoices", :vcr do
      expect(page).to have_link("Merchant Invoices")

      click_link "Merchant Invoices"
      expect(current_path).to eq(merchant_invoices_path(@merchant))
    end
  end
end
