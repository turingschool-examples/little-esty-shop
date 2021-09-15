require 'rails_helper'

RSpec.describe 'Merchant#dashboard' do
  describe 'dashboard' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'JJ')
    end
#     As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
    it "has a merchant name" do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end

    it "lists an link to the items and invoices index" do
      # visit "/merchants/#{@merchant_1.id}/dashboard"
      visit "/merchants/#{@merchant_1.id}/dashboard"

      click_link 'Items Index'

      expect(current_path).to eq(merchant_items_path(@merchant_1))


    end
  end
end
