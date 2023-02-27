require 'rails_helper'

RSpec.describe 'Admin merchant new page' do 
  describe 'when I visit a admin merchant new page' do 
    it 'will have a form to create a new merchant' do 
      visit new_admin_merchant_path
    
      expect(page).to have_field('Name:')
      expect(page).to have_button("Create Merchant")
    end
  end
end