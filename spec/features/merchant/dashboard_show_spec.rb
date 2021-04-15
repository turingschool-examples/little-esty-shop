require 'rails_helper'

RSpec.describe 'Merchant DashBoard Index' do
  before :each do
    @merchant1 = create(:merchant)

    # visit "/merchants/#{@merchant1.id}/dashboard"
    visit merchant_dashboard_index_path(@merchant1)
  end

  describe 'As a merchant,' do
    describe 'When I visit my merchant dashboard (/merchant/merchant_id/dashboard)' do
      it 'shows the name of my merchant' do

        expect(page).to have_content(@merchant1.name)
      end

      it 'Shows a link to my merchant items index' do
        within(".navbar") do
          expect(page).to have_link('My Items')
          click_link('My Items')
          expect(current_path).to eq(merchant_items_path(@merchant1))
        end
      end

    it 'Shows a link to my invoice index' do
        within(".navbar") do
          expect(page).to have_link('My Invoices')
          click_link('My Invoices')
          expect(current_path).to eq(merchant_invoices_path(@merchant1))
        end
      end
    end
  end
end
