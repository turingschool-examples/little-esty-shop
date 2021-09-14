require 'rails_helper'
# rspec spec/features/merchants/dashboard_spec.rb
RSpec.describe 'Merchant Dashboard Show Page' do
  describe 'Merchant Dashboard Show Page' do
    it 'shows merchant dashbaord attributes' do
      merchant1 = create(:merchant)
      visit merchant_dashboard_path(merchant1.id)

      expect(page).to have_content(merchant1.name)
    end
  end
end
