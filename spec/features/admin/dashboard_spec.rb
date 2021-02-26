require "rails_helper"

RSpec.describe"As an admin" do
		before :each do
		@mer_1 = create(:merchant)

		@customers = []
		@customers << create(:customer, first_name: "A", last_name: "1")
		@customers << create(:customer, first_name: "B", last_name: "1")
		@customers << create(:customer, first_name: "C", last_name: "1")
		@customers << create(:customer, first_name: "D", last_name: "1")
		@customers << create(:customer, first_name: "E", last_name: "1")
		@customers << create(:customer, first_name: "A", last_name: "2")
		@customers << create(:customer, first_name: "B", last_name: "2")
		@customers << create(:customer, first_name: "C", last_name: "2")
		@customers << create(:customer, first_name: "D", last_name: "2")
		@customers << create(:customer, first_name: "E", last_name: "2")


		#@customers = create_list(:customer, 10)
		@items = create_list(:item, 20, merchant_id: @mer_1.id )

		invoices = @customers.map do |customer|
			create(:invoice,status: 2,customer_id: customer.id)
		end

		invoice_items = invoices.map do |invoice|
			@items.map do |item|
				create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
			end
		end

		results = ["success", "failed"]
		transactions = invoices.map do |invoice|
			create(:transaction, result: "success", invoice_id: invoice.id)
		end
	end

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
			expect(page).to have_content("Name: A 1 -- Total Transactions: 1")
			expect(page).to have_content("Name: B 1 -- Total Transactions: 1")
			expect(page).to have_content("Name: C 1 -- Total Transactions: 1")
			expect(page).to have_content("Name: D 1 -- Total Transactions: 1")
			expect(page).to have_content("Name: E 1 -- Total Transactions: 1")
		end

		it "displays a section for incomplete invoices" do
			visit "/admin"

			invoices = @customers.map do |customer|
				create(:invoice,status: 0,customer_id: customer.id)
			end
			invoice_items = invoices.flat_map do |invoice|
				@items.map do |item|
					create(:invoice_item,status: 0 ,item_id: item.id, invoice_id: invoice.id)
				end
			end
			

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