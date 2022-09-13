require 'rails_helper'

RSpec.describe "merchant dashboard" do
  describe 'As a merchant, When I visit my merchant dashboard' do
    it 'I see the name of my merchant' do
      bob = Merchant.create!(name: "Bob's Soaps")
      sue = Merchant.create!(name: "Sue's Pastries")
      
      visit merchant_dashboards_path(bob)

      expect(page).to have_content(bob.name)
      expect(page).to_not have_content(sue.name)
    end
  end
end
