require 'rails_helper'


RSpec.describe "Admin Merchants Show Page" do

  describe 'As a Visitor' do

    it 'I see the name of the merchant' do
      merch1 = Merchant.create!(name: 'Cheese Company', created_at: Time.now, updated_at: Time.now, status: 1)

      visit "/admin/merchants/#{merch1.id}"
      # save_and_open_page
      expect(page).to have_content("Merchant Name: Cheese Company")
    end
    describe 'Merchant Show has link to edit merchants info' do
      it 'click the link and I am taken to an edit page with a form containg current attributes' do
        merch1 = Merchant.create!(name: 'Cheese Company', created_at: Time.now, updated_at: Time.now, status: 1)

        visit "/admin/merchants/#{merch1.id}"

        within "#update_this_merchant" do
          expect(page).to have_link("Update This Merchant")
        end
        click_on "Update This Merchant"
        expect(current_path).to eq("/admin/merchants/#{merch1.id}/edit")

        # expect(page).to have_content("#{merch1.name}")
      end
    end

    describe "clicking the submit button I am redirected back to the merchant show page" do

      it 'I see the updated info as well as a flash message stating it was succesful' do
        merch1 = Merchant.create!(name: 'Cheese Company', created_at: Time.now, updated_at: Time.now, status: 1)
        visit "/admin/merchants/#{merch1.id}"
        within "#update_this_merchant" do
          expect(page).to have_link("Update This Merchant")
        end
        click_on "Update This Merchant"

        fill_in "Name", with: "Holy Mackerels"
        click_on "Submit"
        # save_and_open_page
        expect(current_path).to eq("/admin/merchants/#{merch1.id}")
        expect(page).to have_content("Holy Mackerels")
        expect(page).to have_content("Update Successful!")
      end

    end

  end
end
