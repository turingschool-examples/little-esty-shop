require 'rails_helper'

RSpec.describe "Admin Merchant Edit Page" do
  describe "As an admin" do
    before :each do
        @merchant_1 = Merchant.create!(name: "Johns Tools")
        @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
    end

    describe "I visit a merchant's admin show page" do

      it "I see a link to update the merchant's information" do
        visit admin_merchant_path(@merchant_1)
        expect(page).to have_link("Update")

        visit admin_merchant_path(@merchant_2)
        expect(page).to have_link("Update")
      end

      it "When I click the link, I am taken to a page to edit this merchant" do
        visit admin_merchant_path(@merchant_1)
        click_link"Update"
        expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))

        visit admin_merchant_path(@merchant_2)
        click_link"Update"
        expect(current_path).to eq(edit_admin_merchant_path(@merchant_2))
      end

      describe "Admin merchant Update page" do

        it "I see a form filled in with the existing merchant attribute information" do
          visit edit_admin_merchant_path(@merchant_1)
          expect(page).to have_field("Name", {with: "#{@merchant_1.name}"})
          expect(page).to_not have_field("Name", {with: "#{@merchant_2.name}"})

          visit edit_admin_merchant_path(@merchant_2)
          expect(page).to have_field("Name", {with: "#{@merchant_2.name}"})
        end

        it "When I update the information in the form and I click 'submit', I am redirected back to the merchant's admin show page where I see the updated information and I see a flash message stating that the information has been successfully updated" do
          visit edit_admin_merchant_path(@merchant_1)

          fill_in "Name",	with: "Billy John Tools"
          click_button"Update Merchant"

          expect(current_path).to eq(admin_merchant_path(@merchant_1))
          expect(page).to have_content("Billy John Tools")
          expect(page).to_not have_content("Johns Tools")
          expect(page).to have_content("Merchant was successfully updated!")
        end
      end
    end
  end
end
