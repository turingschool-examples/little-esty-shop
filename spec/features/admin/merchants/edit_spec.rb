require 'rails_helper'

RSpec.describe 'admin merchant edit page' do
  before :each do
    @merchant = FactoryBot.create(:merchant)
    visit edit_admin_merchant_path(@merchant)
  end

  describe 'User Story 26' do
    it 'has an edit form filled with existing information' do
      expect(page).to have_field(:merchant_name, with: @merchant.name)
    end

    it 'allows the user to update merchant info' do
      fill_in :merchant_name, with: 'Vinnie Boombatz'
      click_button 'Update Merchant'

      expect(current_path).to eq(admin_merchant_path(@merchant))
      expect(page).to have_content('Vinnie Boombatz')
    end
  end
end