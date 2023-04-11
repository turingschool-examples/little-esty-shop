require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
 before(:each) do
  @merchant_1 = FactoryBot.create(:merchant)
  @merchant_2 = FactoryBot.create(:merchant)
  @merchant_3 = FactoryBot.create(:merchant)
 end

  describe 'As a merchant' do
    it 'I can see my merchant dashboard' do
      visit dashboard_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)

      visit dashboard_merchant_path(@merchant_2)

      expect(page).to have_content(@merchant_2.name)
    end
  end
end