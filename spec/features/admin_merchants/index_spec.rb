require 'rails_helper'

# Admin Merchants Index
#
# As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system

RSpec.describe "Admin Merchants Index Page ", type: :feature do
  let!(:merchant1) { create(:merchant, status: 0) }
  let!(:merchant2) { create(:merchant, status: 1) }
  let!(:merchant3) { create(:merchant, status: 0) }
  let!(:merchant4) { create(:merchant, status: 1) }
  let!(:merchants) { create_list(:merchant, 2) }

  describe 'User Story 1 - Admin Merchants Index' do

    it "can display all the merchants" do
      visit '/admin/merchants'

      expect(page).to have_content(merchants[0].name)
      expect(page).to have_content(merchants[1].name)
    end
  end

  describe "Admin Merchant Enable/Disable" do
    it "has a button to disable or enable each merchant and updates status" do
      visit '/admin/merchants'

      within '#enabledMerchants' do
        expect(page).to have_button('Disable')
        expect(page).to have_content(merchant2.name)
        expect(page).to have_content(merchant4.name)

        expect(page).to_not have_content(merchant1.name)
        expect(page).to_not have_content(merchant3.name)
        expect(page).to_not have_button('Enable')
      end
      within '#disabledMerchants' do
        expect(page).to have_button('Enable')
        expect(page).to have_content(merchant1.name)
        expect(page).to have_content(merchant3.name)

        expect(page).to_not have_content(merchant2.name)
        expect(page).to_not have_content(merchant4.name)
        expect(page).to_not have_button('Disable')
      end
      expect(merchant2.status).to eq("enabled")
      within "#enabled-#{merchant2.id}" do
        click_button "Disable"
      end

      expect(current_path).to eq("/admin/merchants")
      merchant2.reload
      expect(merchant2.status).to eq("disabled")
      within '#enabledMerchants' do
        expect(page).to_not have_content(merchant2.name)
      end
      within '#disabledMerchants' do
        expect(page).to have_content(merchant2.name)
      end
      expect(merchant3.status).to eq("disabled")
      within "#disabled-#{merchant3.id}" do
        click_button "Enable"
      end

      expect(current_path).to eq("/admin/merchants")
      merchant3.reload
      expect(merchant3.status).to eq("enabled")
      within '#enabledMerchants' do
        expect(page).to have_content(merchant3.name)
      end
      within '#disabledMerchants' do
        expect(page).to_not have_content(merchant3.name)
      end
    end

    it 'is grouped into sections by status' do 
      visit '/admin/merchants'
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")

      within "#disabledMerchants" do 
        expect(page).to have_button('Enable')
        expect(page).to have_content(merchant1.name)
        expect(page).to have_content(merchant3.name)
        expect(page).to_not have_content(merchant2.name)
      end

      within "#enabledMerchants" do 
        expect(page).to have_button('Disable')
        expect(page).to have_content(merchant2.name)
        expect(page).to have_content(merchant4.name)
        expect(page).to_not have_content(merchant3.name)
      end
    end
  end

  describe 'admin merchant create' do 
    it 'has a link to create a new merchant' do 
      visit "/admin/merchants"

      expect(page).to have_content("Create New Merchant")
      click_link "Create New Merchant"
      expect(current_path).to eq(new_merchant_path)
    end
  end
end
