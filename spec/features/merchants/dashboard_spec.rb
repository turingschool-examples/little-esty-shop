require 'rails_helper'

RSpec.describe 'Merchant Dashboard Page' do

  before :each do
    test_data
  end
  describe 'As a merchant, when I visit my merchant dashboard page' do
    it 'I see the name of the merchant' do
      visit merchant_dashboard_path(@merchant_1)
      expect(page).to have_content(@merchant_1.name)
    end
  end
end