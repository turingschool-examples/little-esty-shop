require "rails_helper"

describe "Merchants Items index", type: :feature do
  before do
    @merchant = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, {merchant_id: @merchant.id}
    @item2 = create :item, {merchant_id: @merchant.id}
    @item3 = create :item, {merchant_id: @merchant2.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}

    visit merchant_items_path(@merchant)
  end

  describe "display" do
    it "displays all items from this merchant" do
      within "#merchant_items" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end

    it "displays all items from this merchant" do
      visit merchant_items_path(@merchant2)
      within "#merchant_items" do
        expect(page).to have_content(@item3.name)
        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item1.name)
      end
    end

    it "links to item show page" do
      visit merchant_items_path(@merchant2)
      within "#merchant_items" do
        expect(page).to have_link("#{@item3.name}")
        click_link("#{@item3.name}")

        expect(page).to have_current_path("/merchants/#{@merchant2.id}/items/#{@item3.id}")
      end
    end
  end
end
