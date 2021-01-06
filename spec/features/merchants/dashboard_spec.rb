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
  end
end