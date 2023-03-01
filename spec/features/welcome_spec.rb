require 'rails_helper'

RSpec.describe "Welcome Page" do
  describe "As a visitor, I see" do 
    it "links to the admin dashboard and merchant dashboard" do
      @merchant = create(:merchant)
      visit "/"
      
      click_link("Admin Dashboard")
      
      expect(current_path).to eq(admin_index_path)

      visit "/"
      click_link("#{@merchant.name} Dashboard")

      expect(current_path).to eq(merchant_dashboard_index_path(@merchant))
    end
  end
end