require 'rails_helper'
RSpec.describe "Admin Merchants Show", type: :feature do 
  let!(:bob) { Merchant.create!(name: "Bob's Beauties") } 
  let!(:rob) { Merchant.create!(name: "Rob's Rarities") } 
  let!(:hob) { Merchant.create!(name: "Hob's Hoootenanies") } 
  let!(:dob) { Merchant.create!(name: "Dob's Dineries") } 
  let!(:zob) { Merchant.create!(name: "7-11") } 

  describe "As an admin" do
    context "When I visit the admin merchants index (/admin/merchants)" do
      before do
        visit admin_merchants_path
      end

      it "Sees the name of" do
        expect(page).to have_content("Bob's Beauties")
        expect(page).to have_content("#{bob.name}")

        expect(page).to have_content("Rob's Rarities")
        expect(page).to have_content("#{rob.name}")

        expect(page).to have_content("Hob's Hoootenanies")
        expect(page).to have_content("#{hob.name}")

        expect(page).to have_content("Dob's Dineries")
        expect(page).to have_content("#{dob.name}")

        expect(page).to have_content("7-11")
        expect(page).to have_content("#{zob.name}")
      end

      it "When I click on the name of a merchant" do
        within "#merchant-#{bob.id}" do
          click_link "Bob's Beauties"

          expect(page).to have_current_path(admin_merchant_path(bob))
        end

        visit admin_merchants_path

        within "#merchant-#{dob.id}" do
          click_link "Dob's Dineries"

          expect(page).to have_current_path(admin_merchant_path(dob))
        end
      end

      it "On the admin merchant show page, I see the name of the merchant" do
        visit admin_merchant_path(bob)

        expect(page).to have_content("Bob's Beauties")
        expect(page).to have_content("#{bob.name}")

        visit admin_merchant_path(zob)

        expect(page).to have_content("7-11")
        expect(page).to have_content("#{zob.name}")
      end

      
      it "I see a link to update the merchant's information. When I click the link, I am taken to a page to edit this merchant." do
        visit admin_merchant_path(bob)

        within('section#merchant_edit') do
          expect(page).to have_link("Edit #{bob.name}'s Merchant Information")
        end

        click_link("Edit #{bob.name}'s Merchant Information")

        expect(current_path).to eq(edit_admin_merchant(bob))
      end
    end
  end
end
