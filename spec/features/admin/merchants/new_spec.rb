require 'rails_helper'

RSpec.describe 'Admin merchant new page' do 
  describe 'when I visit a admin merchant new page' do 
    it 'will have a form to create a new merchant' do 
      visit new_admin_merchant_path
    
      expect(page).to have_field('Name:')
      expect(page).to have_button("Create Merchant")
    end

    it 'can be filled out and create a new merchant that is shown in the admin merchants index page' do 
      visit new_admin_merchant_path

      fill_in :name, with: "Larry's Lamps"
      click_button 'Create Merchant'

      expect(page).to have_current_path(admin_merchants_path)
      expect(page).to have_content("Larry's Lamps\nStatus: disabled")
    end
  end
end