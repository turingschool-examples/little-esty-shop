require "rails_helper"

describe "Merchants Items index", type: :feature do
  before do
    @merchant = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, {merchant_id: @merchant.id, enabled: "enabled"}
    @item2 = create :item, {merchant_id: @merchant.id, enabled: "disabled"}
    @item3 = create :item, {merchant_id: @merchant2.id}
    @item4 = create :item, {merchant_id: @merchant2.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}
    @transaction1 = create :transaction, {result: 0, invoice_id: @invoice1.id, credit_card_expiration_date: 12121212}
  end

  describe "display" do
    it "displays all items from this merchant in order by item", :vcr do
      visit merchant_items_path(@merchant)

      within "#merchant_items" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end

    it "links to item show page", :vcr do
      visit merchant_items_path(@merchant2)

      within "#merchant_items" do
        expect(page).to have_link(@item3.name)
        click_link(@item3.name)

        expect(page).to have_current_path(merchant_item_path(@merchant2, @item3))
      end
    end

    it "has sections for enabled and disabled items", :vcr do
      visit merchant_items_path(@merchant)

      within "#enabled" do
        expect(page).to have_content(@item1.name)
      end
      within "#disabled" do
        expect(page).to have_content(@item2.name)
      end
    end

    it "displays popular items", :vcr do
      visit merchant_items_path(@merchant)

      within "#popular_items" do
        expect(page).to have_content("Total Revenue: $#{@invoice_item1.unit_price}")
        expect(page).to have_link(@item1.name)
        click_link(@item1.name)
        expect(page).to have_current_path(merchant_item_path(@merchant, @item1))
      end
    end

    it "displays best sales day for each item", :vcr do
      visit merchant_items_path(@merchant)

      within "#popular_items" do
        expect(page).to have_content("Best day for sales: #{@invoice1.created_at}")
      end
    end
  end
end
