require 'rails_helper'

RSpec.describe 'merchant show page' do
  before(:each) do
    dummy_data
  end
#  As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
  describe 'as a merchant when I visit my dashboard' do
    it 'displays the name of merchant' do
      visit "/merchants/#{@merch_1.id}/dashboard"
      expect(page).to have_content(@merch_1.name)
      expect(page).to have_no_content(@merch_2.name)
    end
  end
end