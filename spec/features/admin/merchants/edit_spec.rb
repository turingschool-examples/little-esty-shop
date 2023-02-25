require 'rails_helper'

describe 'edit admin merchant page' do
  describe 'update merchant form' do
    before do
      @merchant = create(:merchant)
      visit edit_admin_merchant_path(@merchant.id)
    end
    it 'should have a title' do
      save_and_open
      expect(page).to have_content "Edit Merchant #{@merchant.id}"
    end
    it 'should be prefilled with the merchant information'
    it 'can fill in new information'
    it 'when I click submit, I am back at the merchant show page'
    it 'where I see the updated '
  end
end