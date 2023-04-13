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

    it 'displays a link to merchant items index' do
      visit "/merchants/#{@merch_1.id}/dashboard"
      within("#my-items") do
       expect(page).to have_link('My Items')

       click_link('My Items')
      end
       expect(current_path).to eq("/merchants/#{@merch_1.id}/items")
    end

    it 'displays a link to merchant invoices index' do
      visit "/merchants/#{@merch_1.id}/dashboard"
      within("#my-invoices") do
       expect(page).to have_link('My Invoices')

       click_link('My Invoices')
      end
       expect(current_path).to eq("/merchants/#{@merch_1.id}/invoices")
    end


  end
end
