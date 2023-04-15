require 'rails_helper'

RSpec.describe "admin/merchants/show page" do
  describe "display" do
    before do
      test_data
    end

    it "shows the name of the merchant" do
      visit admin_merchant_path(@merchant_3)

      expect(page).to have_content("#{@merchant_3.name}'s shop")
      
      visit admin_merchant_path(@merchant_4)

      expect(page).to have_content("#{@merchant_4.name}'s shop")
    end
  end
end