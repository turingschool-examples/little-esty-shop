require 'rails_helper'

RSpec.describe 'Merchants Dashboard Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Klein, Rempel and Jones')
    @merchant2 = Merchant.create!(name: 'Hand-Spencer')
  end

  describe 'when I visit the merchant dashboard' do
    it 'sees the name of my merchant' do
      visit "/merchants/#{@merchant1.id}/dashboard"

      expect(current_path).to eq("/merchants/#{@merchant1.id}/dashboard")
      expect(page).to have_content('Klein, Rempel and Jones')
      expect(page).to_not have_content('Hand-Spencer')
    end
  end
end
