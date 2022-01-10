require 'rails_helper'

RSpec.describe 'New Merchant Creation' do
  describe 'when I click on the link to create a new merchant' do
    it 'links to a new page where a new merchant can be created via a form' do
      visit '/admin/merchants'

      click_link('Create a New Merchant')
      expect(current_path).to eq('/admin/merchants/new')
    end

    it 'can create a new merchant' do
      visit '/admin/merchants/new'
      fill_in('Name', with: 'TEsty Merchant')
      click_button('Create Merchant')

      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content('TEsty Merchant')
    end
  end
end
