require 'rails_helper'

RSpec.describe 'Admin Merchant Create' do
  describe 'new merchant form' do
    it 'renders the new form creates a new merchant on the merchant index page' do
      visit '/admin/merchants/new'

      expect(page).to have_content("New Merchant")
      fill_in 'Name', with: 'A very new Merchant'
      click_button 'Submit'

      expect(page).to have_current_path("/admin/merchants")
      expect(page).to have_content('A very new Merchant')
      expect(page).to have_content('Disabled')
    end
  end

  describe 'edit merchant form' do
    it 'allows the admin to edit a merchants information' do
      @merchant_1 = create(:enabled_merchant)

      visit "admin/merchants/#{@merchant_1.id}/edit"

      expect(page).to have_content(@merchant_1.name)

      fill_in 'Name', with: 'Brand new company name'
      click_button 'Update'

      expect(page).to have_current_path("admin/merchants/#{@merchant_1.id}")
      expect(page).to have_current_path('Brand new company name')
      expect(page).to have_content("#{@merchant_1.name}'s information has been updated")
    end
  end
end
