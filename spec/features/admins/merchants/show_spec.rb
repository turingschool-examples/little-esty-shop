require 'rails_helper'

RSpec.describe "The Admin Merchants Show Page" do
  before(:each) do
    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)
  end
  
  describe "User Story 26" do
    it 'When an admin visits a merchants show page, there is a link to update merchant info and when clicked, are taken to the page to edit this merchant' do
      @merchant = create(:merchant)

      visit admin_merchant_path(@merchant)

      expect(page).to have_link("Update Merchant", href: edit_admin_merchant_path(@merchant))

      click_link "Update Merchant"

      expect(current_path).to eq(edit_admin_merchant_path(@merchant))
    end
  end
end