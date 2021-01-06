require 'rails_helper'

RSpec.describe 'merchant dashboard index', type: :feature do
  describe 'as a merchant' do
    before(:each) do
      @merchant = create(:merchant)
    end

    it 'When I visit my merchant dashboard then I see the name of my merchant' do
      visit merchant_dashboard_index_path(@merchant)
      expect(page).to have_content(@merchant.name)
    end

    it 'When I visit my merchant dashboard Then I see link to my merchant items index (/merchant/merchant_id/items) And I see a link to my merchant invoices index (/merchant/merchant_id/invoices)' do
      visit merchant_dashboard_index_path(@merchant)
      expect(page).to have_link('Merchant Items', href: merchant_items_path(@merchant))
      expect(page).to have_link('Merchant Invoices', href: merchant_invoices_path(@merchant))
    end
  end
end