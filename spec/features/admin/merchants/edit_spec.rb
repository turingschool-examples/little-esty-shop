require 'rails_helper'

RSpec.describe "admin merchants edit" do

  before(:each) do
    @merchant_1 = Merchant.create!(name: "Mel's Travels")
    @merchant_2 = Merchant.create!(name: "Hady's Beach Shack")
    @merchant_3 = Merchant.create!(name: "Huy's Cheese")
  end

  describe 'merchant edit' do
    it 'links to a merchant edit page' do
      visit "/admin/merchants/#{@merchant_1.id}"
  
      click_on("Update #{@merchant_1.name}")

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

      fill_in "Name", with: "Merchanty Merchant"
      click_on("Update")
      
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
      expect(@merchant_1.name).to eq("Merchanty Merchant")
    end
  end
end