require 'rails_helper'

RSpec.describe "Merchant_Items#Show", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)

    @item_1 = create(:item, merchant: @merchant)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 1, status: "packaged", created_at: Date.new(2023,1,2))
    @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 1, status: "packaged", created_at: Date.new(2023,1,3))

    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_2.id, result: 0)
    create(:transaction, invoice_id: @invoice_3.id, result: 0)

    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)


    visit "/merchants/#{@merchant.id}/items/#{@item_1.id}"
  end

  describe "User Story 7" do
    it "shows the name, description, and current selling price" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Description: #{@item_1.description}")
      expect(page).to have_content("Current Price: $#{@item_1.unit_price.to_f/100}")
    end
  end

  describe "User Story 8" do
    it "has a link to update the item that takes me to an edit page" do
      expect(page).to have_link("Update Item", href: "/merchants/#{@merchant.id}/items/#{@item_1.id}/edit")
      click_link "Update Item"
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}/edit")
    end
  end
end