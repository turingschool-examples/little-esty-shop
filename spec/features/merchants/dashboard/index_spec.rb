require 'rails_helper'

RSpec.describe "Merchant Dashboard" do 
  before(:each) do 
    @merchant = create(:merchant)
  end
  describe "When I vist a merchants dashboard" do 
    it "shows the merchants name" do 
      visit "/merchant/#{@merchant.id}/dashboard"

      expect(page).to have_content(@merchant.name)
    end
  end
end