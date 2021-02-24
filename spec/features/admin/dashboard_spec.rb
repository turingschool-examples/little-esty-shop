require "rails_helper"

RSpec.describe"As an admin" do
	describe "when I visit the admin dashboard" do
		it "renders an admin header" do
			visit "/admin"
			within("#admin-header")do
				expect(page).to have_content("Admin Dashboard")
			end
		end

		it"has links to merchant and invoices indexes"do
			visit "/admin"
			expect(page).to have_link "Admin Merchants Index"
			expect(page).to have_link "Admin Invoices Index"
		end

		it"shows the top 5 customers and their number of transactions"do
			visit "/admin"
		end

	end
	describe"when I click on the index links"do

		it"takes you to the admin merchants index"do
			visit "/admin"
			click_link "Admin Merchants Index"
			expect(current_path).to eq("/admin/merchants")
		end

		it"takes you to the admin invoices index"do
			visit "/admin"
			click_link "Admin Invoices Index"
			expect(current_path).to eq("/admin/invoices")
		end

	end
end