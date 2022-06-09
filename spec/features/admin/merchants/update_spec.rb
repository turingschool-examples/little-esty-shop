require 'rails_helper'

RSpec.describe "the admin merchant update" do
  let!(:merchant1) { Merchant.create!(name: 'REI') }

before do
  visit edit_admin_merchant_path(merchant1)
end

  describe 'the merchant update' do
    it "shows the merchant edit form has attributes" do

      expect(find('form')).to have_content('Name')
    end
  end

  context 'given valid data' do
    it "can submit an edit form and update the merchant" do
      fill_in 'merchant[name]', with: 'Black Diamond'
      click_on "Update Merchant"

      expect(current_path).to eq(admin_merchant_path(merchant1))
      expect(page).to have_content('Black Diamond')
      expect(page).to_not have_content('REI')
    end
  end
end
