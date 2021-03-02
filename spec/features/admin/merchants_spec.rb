require "rails_helper"

RSpec.describe "As an admin" do
	before :each do 
			@mer_1 = create(:merchant)
	end
	describe "When I visit the admin merchant index" do
		it "displays the name of each merchant in the system" do
			visit "/admin/merchants"
			expect(page).to have_content("#{@mer_1.name}")
		end

		it "shows a link to update the merchants info" do
			visit "/admin/merchants/#{@mer_1.id}"

			expect(page).to have_link("Update Merchant")
		end

		it "updates a merchant by clicking its name" do
			visit "/admin/merchants/#{@mer_1.id}"
			click_on("Update Merchant")
			expect(current_path).to eq("/admin/merchants/#{@mer_1.id}/edit")
			fill_in "name", with: "Test 1"
			click_on("Submit")
			expect(page).to have_content("Merchant updated successfully")
			expect(page).to have_content("Test 1")
			expect(page).not_to have_content("#{@mer_1.name}")
		end

		describe "When I click create merchant " do
			it "takes me to a form to fill out info" do
				visit "/admin/merchants"
				expect(page).to have_link("Create New Merchant")
				click_on "Create New Merchant"
				expect(current_path).to eq("/admin/merchants/new")
				fill_in "name", with: "merchant 1"
				click_on ("Submit")
				expect(current_path).to eq("/admin/merchants")
				expect(page).to have_content("merchant 1")
				expect(page).to have_button("Enable")
			end
		end
	end
end	