require 'rails_helper'

RSpec.describe "Merchant_Items#Edit", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")

    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    
    create(:transaction, invoice_id: @invoice_1.id, result: 0)

    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)

    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit"
  end

  describe "User Story 8" do
    it "shows a form filled in with the existing attribute information" do
      expect(page).to have_field("Name", with: @item_1.name)
      expect(page).to have_field("Description", with: @item_1.description)
      expect(page).to have_field("Unit price", with: @item_1.unit_price)
    end
    
    it "allows me to update the item info and submit the form" do
      fill_in :item_name, with: "Updated Name"
      fill_in :item_description, with: "Updated Description"
      fill_in :item_unit_price, with: "3"
      click_button "Update #{@item_1.name}"

      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
      expect(page).to have_content("Updated Name")
      expect(page).to have_content("Updated Description")
      expect(page).to have_content("3")
    end
  end
end
