require 'rails_helper'

# Admin Merchants Index
#
# As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system

RSpec.describe "Admin Merchants Index Page ", type: :feature do
  describe 'User Story 1 - Admin Merchants Index' do
    let!(:merchants) { create_list(:merchant, 2) }

    it "can display all the merchants" do
      visit '/admin/merchants'

      expect(page).to have_content(merchants[0].name)
      expect(page).to have_content(merchants[1].name)
    end
  end

  describe "Admin Merchant Enable/Disable" do
    let!(:merchant1) { create(:merchant, status: 0) }
    let!(:merchant2) { create(:merchant, status: 1) }
    let!(:merchant3) { create(:merchant, status: 0) }
    let!(:merchant4) { create(:merchant, status: 1) }
    # Then next to each merchant name I see a button to disable or enable that merchant.
    # When I click this button
    # Then I am redirected back to the admin merchants index
    # And I see that the merchant's status has changed
    it "has a button to disable or enable each merchant and merchants are grouped together by status" do
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
      expect(merchant2.status).to eq("Enabled")
      within "#enabled-#{merchant2}" do
        click_button "Disable"
      end

      expect(current_path).to eq("/admin/merchants")
      merchant2.reload
      expect(merchant2.status).to eq("Disabled")
      within '#enabledMerchants' do
        expect(page).to_not have_content(merchant2.name)
      end
      within '#disabledMerchants' do
        expect(page).to have_content(merchant2.name)
      end
      expect(merchant3.status).to eq("Disabled")
      within "#disabled-#{merchant3}" do
        click_button "Enable"
      end

      expect(current_path).to eq("/admin/merchants")
      merchant3.reload
      expect(merchant3.status).to eq("Enabled")
      within '#enabledMerchants' do
        expect(page).to have_content(merchant3.name)
      end
      within '#disabledMerchants' do
        expect(page).to_not have_content(merchant3.name)
      end
    end
  end
end
