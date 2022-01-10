require 'rails_helper'

RSpec.describe 'Merchant Update' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

  scenario 'visitor sees form to edit a merchant' do
    visit edit_admin_merchant_path(merchant_1.id)

    expect(find('form')).to have_content('Name')
  end

  describe 'visitor gives updated information' do
    it 'submits the edit form and updates the merchant' do
      visit edit_admin_merchant_path(merchant_1.id)
      fill_in 'Name', with: "Wrong Swanson"
      click_button 'Update Merchant'

      expect(current_path).to eq(admin_merchant_path(merchant_1.id))
      expect(page).to have_content("Wrong Swanson")
      expect(page).to have_content("Successfully Updated Merchant Information")
    end
  end
end
