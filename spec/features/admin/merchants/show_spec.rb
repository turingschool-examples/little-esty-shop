require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end
  describe 'Admin Merchant Show Page' do
    it 'can show a Merchant name' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
    end
  end
end