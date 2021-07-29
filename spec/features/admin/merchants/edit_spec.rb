require 'rails_helper'

RSpec.describe 'merchant end page' do
  before(:each) do
    @merchant = create(:merchant)

    visit edit_admin_merchant_path(@merchant.id)
  end

  describe 'update form' do
    it 'admin can fill in form to update merchant information' do
      fill_in 'name', with: 'Apple'
      click_on 'Submit'

      expect(current_path).to eq(admin_merchant_path(@merchant.id))
      expect(page).to have_content('Apple')
    end
  end
end
