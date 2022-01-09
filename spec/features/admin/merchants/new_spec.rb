require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  describe 'new' do

    it 'shows a form to create a new merchant and sends back to merchant index' do
      visit "admin/merchants/new"
      save_and_open_page
      fill_in('Name', with: 'Marco Polo')

      click_button('Submit')
      expect(current_path).to eq("/admin/merchants")
    end
  end
end
