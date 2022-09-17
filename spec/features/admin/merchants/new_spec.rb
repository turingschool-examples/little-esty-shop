require 'rails_helper'

RSpec.describe "Admin Merchant Create New" do
  describe "As an admin" do
    describe "When I visit the admin merchants index" do
      before :each do
          @merchant_1 = Merchant.create!(name: "Johns Tools")
          @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
      end


          #       Admin Merchant Create

      # As an admin,
      # I see a link to create a new merchant.
      # When I click on the link,

      # I am taken to a form that allows me to add merchant information.
      # When I fill out the form I click ‘Submit’
      # Then I am taken back to the admin merchants index page
      # And I see the merchant I just created displayed
      # And I see my merchant was created with a default status of disabled.

      it 'US#29 - Admin Merchant Create - new path' do
        visit admin_merchants_path

        click_button "Create New Merchant"
        expect(current_path).to eq(new_admin_merchant_path)
      end


      it "will take us to the form to add merchant info" do

        visit new_admin_merchant_path

        fill_in "Name", with: "Billy Bobs Burgers"
        click_button "Submit"

        expect(current_path).to eq(admin_merchants_path)
        within("#disabled-merchants") do
          expect(page).to have_content("Billy Bobs Burgers")
        end
      end
      
    end
  end
end