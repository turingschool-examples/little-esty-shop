require 'rails_helper'

RSpec.describe 'Merchant Creation' do
  describe 'the admin merchant new' do
    it 'renders the new form' do
      visit new_admin_merchant_path

      expect(find('form')).to have_content('Name')
    end
  end

  describe 'the merchant create' do
      it 'creates the merchant' do
        visit new_admin_merchant_path

        fill_in 'Name', with: 'New Merchant'
        click_button 'Submit'

        expect(page).to have_current_path(admin_merchants_path)
        expect(page).to have_content('New Merchant')
      end
    end
  end 
