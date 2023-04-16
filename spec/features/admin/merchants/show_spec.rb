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

  describe "create / edit merchants" do
    before do
      test_data
    end

    it "has an edit link" do
      visit admin_merchant_path(@merchant_5)

      expect(page).to have_link("Edit #{@merchant_5.name}", href: edit_admin_merchant_path(@merchant_5))
      
      visit admin_merchant_path(@merchant_6)

      expect(page).to have_link("Edit #{@merchant_6.name}", href: edit_admin_merchant_path(@merchant_6))
    end
  end
end