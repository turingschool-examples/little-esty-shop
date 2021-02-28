require "rails_helper"

RSpec.describe "When I visit '/merchant/merchant_id/items'" do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)
    @item6 = create(:item, merchant_id: @merchant1.id)

    @invoice1 = create(:invoice, created_at: "2013-03-25 09:54:09 UTC")
    @invoice2 = create(:invoice, created_at: "2012-03-17 09:54:09 UTC")
    @invoice3 = create(:invoice, created_at: "2011-03-01 09:54:09 UTC")
    @invoice4 = create(:invoice, created_at: "2020-02-20 09:54:09 UTC")
    @invoice5 = create(:invoice, created_at: "2019-05-12 09:54:09 UTC")
    @invoice6 = create(:invoice, created_at: "2015-12-25 09:54:09 UTC")

    @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 2, quantity: 6, unit_price: 100)
    @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 2, quantity: 5, unit_price: 100)
    @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 2, quantity: 4, unit_price: 100)
    @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)
    @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item5.id, status: 2, quantity: 2, unit_price: 100)
    @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item6.id, status: 2, quantity: 1, unit_price: 100)
    @invoice_item7 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item6.id, status: 2, quantity: 1, unit_price: 100)
    @invoice_item8 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item5.id, status: 2, quantity: 2, unit_price: 100)
    @invoice_item9 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item4.id, status: 2, quantity: 3, unit_price: 100)
    @invoice_item10 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item3.id, status: 2, quantity: 4, unit_price: 100)
    @invoice_item11 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item2.id, status: 2, quantity: 5, unit_price: 100)
    @invoice_item12 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item1.id, status: 2, quantity: 6, unit_price: 100)

    @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: "failed")
    @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: "failed")
    @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: "failed")
    @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: "failed")
    @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: "failed")
    @transaction6 = create(:transaction, invoice_id: @invoice6.id, result: "failed")
    @transaction7 = create(:transaction, invoice_id: @invoice1.id, result: "success")
    @transaction8 = create(:transaction, invoice_id: @invoice2.id, result: "success")
    @transaction9 = create(:transaction, invoice_id: @invoice3.id, result: "success")
    @transaction10 = create(:transaction, invoice_id: @invoice4.id, result: "success")
    @transaction11 = create(:transaction, invoice_id: @invoice5.id, result: "success")
    @transaction12 = create(:transaction, invoice_id: @invoice6.id, result: "success")
  end

  describe "Next to each of the 5 most popular items there is a date with the most sales for item" do
    it "Has a label ~Top selling date for <item> was: ~" do
      visit merchant_items_path(@merchant1)
      save_and_open_page
      within(".most_popular_items") do
        expect(page).to have_content("Top selling date for #{@item1.name} was: #{@item1.top_selling_date}")
      end
    end
  end
end
