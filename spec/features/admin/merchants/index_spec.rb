require 'rails_helper'

RSpec.describe "admin/merchants index", type: :feature do
  describe "display" do
    before do
      test_data
    end
    
    it "displays all merchants" do
      visit admin_merchants_path
      
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
      expect(page).to have_content(@merchant_5.name)
      expect(page).to have_content(@merchant_6.name)
    end

    it "has links to merchant show pages" do
      visit admin_merchants_path

      expect(page).to have_link(@merchant_1.name, href: admin_merchant_path(@merchant_1))
      expect(page).to have_link(@merchant_2.name, href: admin_merchant_path(@merchant_2))
      expect(page).to have_link(@merchant_3.name, href: admin_merchant_path(@merchant_3))
      expect(page).to have_link(@merchant_4.name, href: admin_merchant_path(@merchant_4))
      expect(page).to have_link(@merchant_5.name, href: admin_merchant_path(@merchant_5))
      expect(page).to have_link(@merchant_6.name, href: admin_merchant_path(@merchant_6))
    end
  end
end