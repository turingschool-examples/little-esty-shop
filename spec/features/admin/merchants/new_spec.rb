require 'rails_helper'

RSpec.describe "Admin Merchant Create New" do
  describe "As an admin" do
    describe "When I visit the admin merchants index" do

      it 'I see a link to create a new merchant when I click on the link, I am taken to a form that allows me to add merchant information.' do
        visit admin_merchants_path

        click_button "Create New Merchant"
        expect(current_path).to eq(new_admin_merchant_path)
      end

      it "When I fill out the form I click 'Submit' I am taken back to the admin merchants index page, and I see the merchant I just created displayed with a default status of disabled." do
        visit new_admin_merchant_path

        fill_in "Name", with: "Billy Bobs Burgers"
        click_button "Create Merchant"

        expect(current_path).to eq(admin_merchants_path)
        within("#disabled-merchants") do
          expect(page).to have_content("Billy Bobs Burgers")
        end
        
      end
    end
  end
end