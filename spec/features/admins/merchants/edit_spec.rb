require "rails_helper"

RSpec.describe "The Admin Merchants Index" do
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
    before(:each) do
      @merchant = create(:merchant)

      visit edit_admin_merchant_path(@merchant)
    end

    it 'can see a form filled in with the existing merchant info' do
      expect(page).to have_field(:merchant_name, with: @merchant.name)
      expect(page).to have_button("Submit")
    end

    it 'can update the information, click submit, be redirected to the show page with updated information and
      see a flash message stating the information has been succesfully updated' do
      fill_in :merchant_name, with: "Trader Bob's"
      click_button "Submit"

      expect(current_path).to eq(admin_merchant_path(@merchant))

      expect(page).to have_content("Trader Bob's")
      within("#flash_message") { expect(page).to have_content("Trader Bob's Information has been Updated") }
    end

    it 'can see a flash message acknowledging information was missing and cannot update' do
      fill_in :merchant_name, with: ""
      click_button "Submit"

      expect(current_path).to eq(edit_admin_merchant_path(@merchant))

      expect(page).to have_content(@merchant.name)
      within("#flash_message") { expect(page).to have_content("Unable to Update - Missing Information") }
    end
  end
end