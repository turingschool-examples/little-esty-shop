require 'rails_helper'

RSpec.describe "The Admin Merchants New Page" do
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

    visit new_admin_merchant_path
  end
  describe "User Story 29" do
    it "shows the admin a form to add merchant information, when the form is filled and submitted, they are redirected to the admin merchant index
    and the merchant they just created is shown with a default status of disabled" do

      expect(page).to have_field(:merchant_name)
      expect(page).to have_button("Submit")

      fill_in :merchant_name, with: "Dawson"

      click_button "Submit"

      expect(current_path).to eq(admin_merchants_path)

      within("#Merchant-#{Merchant.last.id}") { expect(page).to have_content(Merchant.last.name) }
      within("#flash_message") { expect(page).to have_content("#{Merchant.last.name} has been Created") }

    end

    it "Unable to create merchant without a valid input" do

      click_button "Submit"

      expect(current_path).to eq(new_admin_merchant_path)

      within("#flash_message") { expect(page).to have_content("Unable to Create - Missing Information") }
    end
  end
end