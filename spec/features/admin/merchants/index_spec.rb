require 'rails_helper'
RSpec.describe "Admin Merchants", type: :feature do 
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

      it "Sees the name of each merchant in the system" do
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
    end
  end
end