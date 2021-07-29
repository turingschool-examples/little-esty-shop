require 'rails_helper'

RSpec.describe 'admin merchant show page' do
  before(:each) do
    @merchant = create(:merchant)

    visit admin_merchant_path(@merchant.id)
  end

  describe 'contents' do
    it 'displays the name of the merchant' do
      expect(page).to have_content(@merchant.name)
    end

    it 'has a link to update merchant information' do
      expect(page).to have_link('Update Merchant')
    end
  end

  describe 'update button functionality' do
    it 'when clicking on link, you are taken to the admin merchant edit page' do
      click_on 'Update Merchant'

      expect(current_path).to eq(edit_admin_merchant_path(@merchant.id))
    end
  end
end
