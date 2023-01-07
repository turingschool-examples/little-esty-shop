require 'rails_helper'

RSpec.describe 'admin merchant show' do
  describe "User Story 25" do
    it 'has the merchant name' do
      merchant = FactoryBot.create(:merchant)
      visit admin_merchant_path(merchant)

      expect(page).to have_content(merchant.name)
    end
  end
end