require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  let(:merchant1) do 
    create(:merchant)
  end

  describe "Displays" do
    it "the merchant name" do
      visit dashboard_merchant_path(merchant1)

      expect(page).to have_content(merchant1.name)
    end

    it "link to merchant's item index" do
      visit dashboard_merchant_path(merchant1)

      expect(page).to have_link("My Items")

      click_link "My Items"

      expect(current_path).to eq(merchant_items_path(merchant1))
    end
  end
end