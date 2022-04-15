require 'rails_helper'


RSpec.describe "Admin Merchants Show Page" do

  describe 'As a Visitor' do

    it 'I see the name of the merchant' do
      merch1 = Merchant.create!(name: 'Cheese Company', created_at: Time.now, updated_at: Time.now, status: 1)

      visit "/admin/merchants/#{merch1.id}"
      # save_and_open_page
      expect(page).to have_content("Merchant Name: Cheese Company")
    end

    it 'Has a link to a page to edit this merchants information, a form is filled with existing info' do
      merch1 = Merchant.create!(name: 'Cheese Company', created_at: Time.now, updated_at: Time.now, status: 1)

      visit "/admin/merchants/#{merch1.id}"

      within "#update_this_merchant" do
        expect(page).to have_link("Update This Merchant")
      end
      click_on "Update This Merchant"
      expect(current_path).to eq("/admin/merchants/#{merch1.id}/edit")
    end


  end
end
