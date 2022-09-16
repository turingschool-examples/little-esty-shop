require 'rails_helper'

RSpec.describe 'Admin Merchant New' do
  describe "Can create a new merchant" do
    it 'has link to create new merchant' do
      visit admin_merchants_path

      expect(page).to have_link("Create New Merchant")
    end

    it 'clicking link takes admin to new page' do

      visit admin_merchants_path
      click_link("Create New Merchant")
      expect(current_path).to eq(new_admin_merchant_path)
    end

    it 'new page has a form to add merchant info' do

      visit admin_merchants_path
      click_link("Create New Merchant")

      fill_in :name, with: "Bobs Bobbery"
      click_button 'Submit'
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content('Bobs Bobbery')

    end

    it 'new merchants are by default disabled' do
      visit admin_merchants_path
      click_link("Create New Merchant")

      fill_in :name, with: "Bobs Bobbery"
      click_button 'Submit'
      new_merchant = Merchant.last
      within '#disabled_merchants' do
        within "#merchant_#{new_merchant.id}" do
          expect(page).to have_content(new_merchant.name)
        end
      end
      within '#enabled_merchants' do
        expect(page).to_not have_css("#merchant_#{new_merchant.id}")
      end
    end

    it 'returns to new page with error message if name not filled out' do
      visit admin_merchants_path
      click_link("Create New Merchant")

      fill_in :name, with: ""
      click_button 'Submit'
      expect(current_path).to eq(new_admin_merchant_path)
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end
