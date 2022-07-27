require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe "I visit a merchant dashboard" do



    it 'displays the merchant name' do
      merchant = Merchant.create!(name: "Josey Wales", created_at: Time.now, updated_at: Time.now)
      visit merchant_dashboard_index_path(merchant)
      expect(page).to have_content(merchant.name)
    end
  end
end
