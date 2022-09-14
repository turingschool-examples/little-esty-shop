require 'rails_helper'

RSpec.describe 'Admin Merchants Edit' do
  describe "Can update merchant attributes" do
    it 'has a link to update merchant info' do
      merch_1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch_2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      visit "/admin/merchants/#{merch_1.id}"

      click_link("Edit Merchant")
      expect(current_path).to eq(edit_admin_merchant_path(merch_1))
    end
  end

  describe "on page, the name field is already filled in with the merchants name" do
    it 'name field is prefilled with merchants name' do
      merch_1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch_2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      visit "/admin/merchants/#{merch_1.id}"
      expect(page).to have_content(merch_1.name)
      click_link("Edit Merchant")
      click_button("Submit")
      within('#merchants_name') do
        expect(page).to have_content(merch_1.name)
        expect(page).to_not have_content(merch_2.name)
      end
    end 
  end

  describe 'when info is updated and form submitted, returned back to show page to see changes' do
    it 'filling form out and submitting returns back to show page with changes visible' do
      merch_1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch_2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      visit "/admin/merchants/#{merch_1.id}"
      expect(page).to have_content(merch_1.name)
      click_link("Edit Merchant")
      fill_in 'Name', with: 'Bobs Bobbery'
      click_button("Submit")
      expect(current_path).to eq(admin_merchant_path(merch_1))
      within '#merchants_name' do
        expect(page).to have_content("Bobs Bobbery")
        expect(page).to_not have_content(merch_1.name)
      end
    end
  end

  describe 'returning back to show page after edit also triggers a flash message stating things have been updated' do
    it 'filling form out and submitting returns back to show page with changes visible' do
      merch_1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch_2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      visit "/admin/merchants/#{merch_1.id}"
      expect(page).to_not have_content("Merchant successfully updated")
      click_link("Edit Merchant")
      fill_in 'Name', with: 'Bobs Bobbery'
      click_button("Submit")
      expect(page).to have_content("Merchant successfully updated")
    end

    it 'not filling in fields properly returns back to edit page with error message' do
      merch_1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch_2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      visit "/admin/merchants/#{merch_1.id}"
      expect(page).to_not have_content("Merchant successfully updated")
      click_link("Edit Merchant")
      fill_in 'Name', with: ''
      click_button("Submit")
      expect(current_path).to eq(edit_admin_merchant_path(merch_1))
      expect(page).to have_content("Error: Name can't be blank")
    end
  end

  
end
