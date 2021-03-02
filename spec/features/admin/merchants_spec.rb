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

		it "updates a merchant by clicking on the link" do
			visit "/admin/merchants/#{@mer_1.id}"
			click_on("Update Merchant")
			expect(current_path).to eq("/admin/merchants/#{@mer_1.id}/edit")
			fill_in "name", with: "Test 1"
			click_on("Submit")
			expect(page).to have_content("Merchant updated successfully")
			expect(page).to have_content("Test 1")
			expect(page).not_to have_content("#{@mer_1.name}")
		end

	describe "and I click on the name of a merchant" do
	
		it "takes me to the merchant show page" do
			visit "/admin/merchants"
			expect(page).to have_link("#{@mer_1.name}")
			click_link("#{@mer_1.name}")
			expect(current_path).to eq("/admin/merchants/#{@mer_1.id}")
			expect(page).to have_content("#{@mer_1.name}")
		end
	end
	end
end	