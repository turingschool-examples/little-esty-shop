require 'rails_helper'

RSpec.describe 'Admin Merchants Edit Page' do
  before :each do
    @merchant = create(:merchant)

    visit edit_admin_merchant_path(@merchant)

  end

  describe 'as an admin' do
    it "loads with a form populated with merchant's info" do
      within('#form') do
        fill_in('merchant_name', with: 'Some Record')
        click_on 'submit'
      end
      expect(current_path).to eq(admin_merchant_path(@merchant))
    end

    it 'shows flash message if fields are saved blank' do
      visit edit_admin_merchant_path(@merchant)

      within('#form') do
        fill_in('merchant_name', with: '')
        click_on 'submit'
      end

      expect(current_path).to eq(admin_merchant_path(@merchant))
      expect(page).to have_selector('.flash-message')
    end
  end
end
