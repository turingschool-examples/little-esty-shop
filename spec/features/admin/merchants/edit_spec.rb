require 'rails_helper'

RSpec.shared_context 'merchant edit' do
  def name_update
    fill_in 'Name', with: "Carlos Simon's Candy Silo"
    click_on 'Submit'
  end
end

RSpec.describe 'Admin Merchant Edit', type: :feature do

  let!(:carly) { Merchant.create!(name: "Carly Simon's Candy Silo") }

  describe 'As an admin, when I visit admin merchants show' do
    before(:each) do
      visit edit_admin_merchant_path(carly)
    end

    it 'has a form filled in with the existing merchant attribute information' do
      expect(page).to have_field('Name', with: carly.name)
    end

    include_context 'merchant edit'

    it 'When I update the information in the form and I click "submit" then I am redirected back to the merchants admin show page' do
      name_update

      expect(current_path).to eq(admin_merchant_path(carly))
    end

    it 'where I see the updated information' do
      name_update

      within '#merchant-name' do
        expect(page).to have_content("Carlos Simon's Candy Silo")
      end
    end

    it 'And I see a flash message stating that the information has been successfully updated.' do
      name_update

      expect(page).to have_content('Merchant has been successfully updated.')
    end

    it 'and if I leave it blank it refreshes the page and flashes an error' do
      fill_in 'Name', with: ""
      click_on 'Submit'

      expect(current_path).to eq(edit_admin_merchant_path(carly))
      expect(page).to have_content('Empty name not permitted. Please try again.')
    end

    it 'and if I fill it with nothing but spaces but it refreshes the page and flashes an error' do
      fill_in 'Name', with: "   "
      click_on 'Submit'

      expect(current_path).to eq(edit_admin_merchant_path(carly))
      expect(page).to have_content('Empty name not permitted. Please try again.')
    end
  end
end
