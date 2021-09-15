require 'rails_helper'
require 'simplecov'

RSpec.describe 'Merchant#dashboard' do
  describe 'dashboard' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'JJ')
    end
#     As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
    it "has a merchant name" do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
    end
  end
end
