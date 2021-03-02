require "rails_helper"

RSpec.describe "Merchant Items Index Page" do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant2.id)

    @customers = []
    10.times {@customers << create(:customer)}
    @customers.each do |customer|
      create(:invoice, customer_id: customer.id)
    end

    @invoice_1 = @customers.first.invoices.first
    @invoice_2 = @customers.second.invoices.first
    @invoice_3 = @customers.third.invoices.first
    @invoice_4 = @customers.fourth.invoices.first
    @invoice_5 = @customers.fifth.invoices.first
    @invoice_6 = @customers[5].invoices.first
    @invoice_7 = @customers[6].invoices.first

    9.times {create(:transaction, invoice_id: @invoice_1.id, result: 0)}
    8.times {create(:transaction, invoice_id: @invoice_2.id, result: 0)}
    7.times {create(:transaction, invoice_id: @invoice_3.id, result: 0)}
    6.times {create(:transaction, invoice_id: @invoice_4.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_5.id, result: 0)}
    1.times {create(:transaction, invoice_id: @invoice_6.id, result: 1)}
    10.times {create(:transaction, invoice_id: @invoice_7.id, result: 1)}

    @invoice_item_1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_1.id, status: 0)
    @invoice_item_2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_2.id, status: 0)
    @invoice_item_3 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_3.id, status: 1)
    @invoice_item_4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice_4.id, status: 2)
    @invoice_item_5 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_5.id, status: 0)
  end

  describe "When I visit my merchant items index page (merchant/merchant_id/items)" do
    it "I see a list of the names of all of my items" do
      visit "/merchant/#{@merchant1.id}/items"

      within("#merchant-items") do
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end

    it " has a link for each item name to that merchants show page" do
      visit "/merchant/#{@merchant1.id}/items"

      within("#merchant-items") do
        expect(page).to have_link(@item1.name)
        expect(page).to have_link(@item2.name)
        expect(page).to_not have_link(@item3.name)

        click_link(@item1.name, match: :first)
        expect(current_path).to eq("/merchant/#{@merchant1.id}/items/#{@item1.id}")
      end
    end

    it "displays name of top five most popular items ranked by total revenue generated" do
      visit "/merchant/#{@merchant1.id}/items"

      within("#top-five-items") do
        expect(page).to have_content("Top Items")
      end
    end

    it "displays the date with the most sales for the top five items" do
      visit "/merchant/#{@merchant1.id}/items"

      within("#top-five-items") do
        expect(page).to have_content("Top Items")
        expect(page).to have_content("Top day for #{@item1.name} was #{@invoice_item_1.created_at.strftime('%m/%d/%Y')}")
        save_and_open_page
      end
    end
    # Merchant Items Index: Top Item's Best Day
    # When I visit the items index page
    # Then next to each of the 5 most popular items I see the date with the most sales for each item.
    # And I see a label “Top selling date for <item name> was <date with most sales>"
    # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
  end
end
