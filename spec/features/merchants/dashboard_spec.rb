require 'rails_helper'

RSpec.describe 'Merchant Dashboard page' do
  context 'when i visit my merchant dashboard' do
    before(:each) do
      @sprouts = create(:merchant)
      visit "/merchants/#{@sprouts.id}/dashboard"
      save_and_open_page
    end

    it 'shows the name of my merchant' do
      expect(page).to have_content('Sprouts')
    end

    it 'has a link to my items page' do
      click_link('My Items')
      expect(current_path).to eq("/merchants/#{@sprouts.id}/items")
    end

    it 'has a link to my invoices index' do
      click_link('My Invoices')
      expect(current_path).to eq("/merchants/#{@sprouts.id}/invoices")
    end
  end
end
