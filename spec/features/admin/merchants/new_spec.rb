require 'rails_helper'

RSpec.describe 'Admin merchants new spec' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
  end
  describe 'as an admin' do
    it 'loads with a form to create a new merchant' do
      visit new_admin_merchant_path

      within('#form') do
        fill_in('merchant_name', with: 'New Record')
        click_on 'Submit'
      end

      expect(current_path).to eq(admin_merchants_path)

      within('#disabled_merchants') do
        expect(page).to have_content('New Record')
      end
    end

  # it 'shows flash message if fields are saved blank' do
#     visit new_admin_merchant_path
#
#     within('#form') do
#       fill_in('merchant_name', with: '')
#       click_on 'Submit'
#     end
#
#     expect(current_path).to eq(new_admin_merchant_path)
#     expect(page).to have_selector('.flash-message')
#   end
  end
end
