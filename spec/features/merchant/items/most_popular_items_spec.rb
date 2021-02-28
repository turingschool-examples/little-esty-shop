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

    @invoice1 = create(:invoice)
    @invoice2 = create(:invoice)
    @invoice3 = create(:invoice)
    @invoice4 = create(:invoice)
    @invoice5 = create(:invoice)
    @invoice6 = create(:invoice)

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

  describe "I see the names of top 5 most popular items by total revenue" do
    it "Each item name is a link to merchant item show page for that item" do
      visit merchant_items_path(@merchant1)

      within(".most_popular_items") do
        expect(@item1.name).to appear_before(@item2.name)
        expect(@item2.name).to appear_before(@item3.name)
        expect(@item3.name).to appear_before(@item4.name)
        expect(@item4.name).to appear_before(@item5.name)
        expect(page).not_to have_content(@item6.name)
      end
    end

    it "I see total revenue generated next to each item name" do
      visit merchant_items_path(@merchant1)
      # save_and_open_page

      within(".most_popular_items") do
        expect(page).to have_content("Total Revenue Generated: $1200.00")
      end
    end
  end
end


# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name
#
# Notes on Revenue Calculation:
#
# Only invoices with at least one successful transaction should count towards revenue

# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items

# Revenue for an invoice item should be calculated as the invoice item unit price multiplied
# by the quantity (do not use the item unit price)
