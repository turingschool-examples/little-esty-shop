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
  end
end