require 'rails_helper'


RSpec.describe 'Edit Merchant through Admin Merchant Show Page' do
  describe 'Update Merchant Show Page' do
    it 'can click link from show page to edit merchant attibutes' do
      merchant_1 = Merchant.create!(name: 'Brylan')
      visit "/admin/merchants/#{merchant_1.id}"

      click_link "Update Brylan"
      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}/edit")

      fill_in :name, with: 'Antonio'
      click_button 'Submit'
      expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      expect(page).to have_content('Antonio')
    end
  end
end
