require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  describe 'view' do

    it 'I see the name of each merchant in the system' do
      visit "/admin/merchants"

      expect(page).to have_content("Merchants")
      expect(page).to have_content(@merchant_1.name)
    end

    it 'Each id links to the admin merchant show page' do
      visit "/admin/merchants"

      click_link "#{@merchant_1.name}"
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end
  end
end
