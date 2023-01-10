require 'rails_helper'

RSpec.describe 'admin merchant show' do
  before :each do
    @merchant = FactoryBot.create(:merchant)
    visit admin_merchant_path(@merchant)
  end

  describe "User Story 25" do
    it 'has the merchant name' do
      expect(page).to have_content(@merchant.name)
    end
  end

  describe 'User Story 26' do
    it 'has a link to update the merchant' do
      expect(page).to have_link("Update Merchant")

      click_link "Update Merchant"

      expect(page).to have_current_path(edit_admin_merchant_path(@merchant))
    end
  end
end