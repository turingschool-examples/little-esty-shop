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
    it "displays merchant name" do
      expect(page).to have_content(@merchant.name)
    end

    it "has a link to view all merchant items" do
      expect(page).to have_link("Merchant Items")

      click_link "Merchant Items"
      expect(current_path).to eq(merchant_items_path(@merchant))
    end

    it "has a link to view all merchant invoices" do
      expect(page).to have_link("Merchant Invoices")

      click_link "Merchant Invoices"
      expect(current_path).to eq(merchant_invoices_path(@merchant))
    end

    it "displays items ready to ship with a link to the item's invoice" do
      expect(@merchant.items_ready_to_ship).to eq([@invoice_item1, @invoice_item2])

      within("#items_to_ship-#{@invoice_item1.id}") do
        expect(page).to have_link(@invoice_item1.invoice.id)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@invoice1.id)
      end

      within("#items_to_ship-#{@invoice_item2.id}") do
        expect(page).to have_link(@invoice_item2.invoice.id)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@invoice1.id)
      end
    end

    it "displays items ready to ship with the date the invoice was created" do
      within("#items_to_ship-#{@invoice_item2.id}") do
        expect(page).to have_link(@invoice_item2.invoice.id)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice_item2.invoice.created_at.strftime("%A, %B %d, %Y"))
      end

      within("#items_to_ship-#{@invoice_item1.id}") do
        expect(page).to have_link(@invoice_item1.invoice.id)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice_item1.invoice.created_at.strftime("%A, %B %e, %Y"))
      end

      expect(@item1.name).to appear_before(@item2.name)
    end
  end
end
