require 'rails_helper'

RSpec.describe 'merchants edit page', type: :feature do
  before(:each) do
  end

  describe 'page appearance' do
    it 'shows the current information for the record' do
      visit 'admin/merchants/1/edit'

      expect(page).to have_content('Name')
      expect(page).to have_content('Schroeder-Jerde')
      expect(page).to have_content('Enabled')
      expect(page).to have_content('Yes')
    end
  end

  describe 'page functionality' do
    it 'allows me to update the info, and redirects me to the show page with a success flash message' do
      new_merchant = Merchant.create(name: 'Big Bird')
      visit "admin/merchants/#{new_merchant.id}/edit"

      fill_in 'Name', with: 'TEST'

      click_on 'Save changes'

      expect(current_path).to eq("/admin/merchants/#{new_merchant.id}")
      expect(page).to have_content('TEST')
      expect(page).to have_content('You have successfully updated this merchant!')
    end
  end
end