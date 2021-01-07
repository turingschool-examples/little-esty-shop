require 'rails_helper'

RSpec.describe "as a merchant" do
  describe "when I visit the merchant dashboard" do
    before(:each) do
      @merchant = Merchant.create!(name: "Buy more stuff")
    end
    it "Then I see the name of my merchant" do
      visit merchant_dashboard_index_path(@merchant.id)

      expect(page).to have_content("#{@merchant.name}")
    end
  end
end
