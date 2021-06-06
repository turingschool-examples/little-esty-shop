require 'rails_helper'

RSpec.describe 'merchants new page', type: :feature do
  describe 'page functionality' do
    it 'allows me to enter details for a new merchant and redirects to admin/merchants/index on creation' do
      visit '/admin/merchants/new'

      expect(page).to have_content('Name')

      fill_in 'Name', with: 'Big Bird'

      click_button 'Save changes'

      expect(current_path).to eq('/admin/merchants')

      expect(page).to have_content('Big Bird')
    end
  end
end