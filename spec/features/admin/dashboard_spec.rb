require "rails_helper"

RSpec.describe"As an admin" do
	before :each do
		@mer_1 = create(:merchant)
		@cust_1 = create(:customer, first_name: "A", last_name: "1")
		@cust_2 = create(:customer, first_name: "B", last_name: "1")
		@cust_3 = create(:customer, first_name: "C", last_name: "1")
		@cust_4 = create(:customer, first_name: "D", last_name: "1")
		@cust_5 = create(:customer, first_name: "E", last_name: "1")
		@cust_6 = create(:customer, first_name: "F", last_name: "1")
		@cust_7 = create(:customer, first_name: "G", last_name: "1")
		@cust_8 = create(:customer, first_name: "H", last_name: "1")
		@cust_9 = create(:customer, first_name: "I", last_name: "1")
		@cust_10 = create(:customer, first_name: "J", last_name: "1")
		@item_1 = create(:item, merchant_id: @mer_1.id)
		@item_2 = create(:item, merchant_id: @mer_1.id)
		@item_3 = create(:item, merchant_id: @mer_1.id)
		@item_4 = create(:item, merchant_id: @mer_1.id)
		@item_5 = create(:item, merchant_id: @mer_1.id)
		@item_6 = create(:item, merchant_id: @mer_1.id)
		@invoice1 = create(:invoice, customer_id: @cust_1.id)
		@invoice2 = create(:invoice, customer_id: @cust_2.id)
		@invoice3 = create(:invoice, customer_id: @cust_3.id)
		@invoice4 = create(:invoice, customer_id: @cust_4.id)
		@invoice5 = create(:invoice, customer_id: @cust_5.id)
		@invoice6 = create(:invoice, customer_id: @cust_6.id)
		@invoice_item1 = create(:invoice_item, status: 0 ,item_id:@item_1.id, invoice_id:@invoice1.id)
		@invoice_item2 = create(:invoice_item, status: 0 , item_id:@item_2.id, invoice_id:@invoice2.id)
		@invoice_item3 = create(:invoice_item, status: 0 , item_id:@item_3.id, invoice_id:@invoice3.id)
		@invoice_item4 = create(:invoice_item, item_id:@item_4.id, invoice_id:@invoice4.id)
		@invoice_item5 = create(:invoice_item, item_id:@item_5.id, invoice_id:@invoice6.id)
		@invoice_item6 = create(:invoice_item, item_id:@item_6.id, invoice_id:@invoice6.id)
		@transaction1 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "failed", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction3 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction4 = create(:transaction, result: "success", invoice_id: @invoice4.id)
		@transaction5 = create(:transaction, result: "success", invoice_id: @invoice5.id)
		@transaction6 = create(:transaction, result: "success", invoice_id: @invoice3.id)
		@transaction7 = create(:transaction, result: "success", invoice_id: @invoice3.id)
		@transaction8 = create(:transaction, result: "success", invoice_id: @invoice6.id)
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
			expect(page).to have_content("Name: A 1 -- Total Transactions: 2")
			expect(page).to have_content("Name: B 1 -- Total Transactions: 2")
			expect(page).to have_content("Name: C 1 -- Total Transactions: 2")
			expect(page).to have_content("Name: D 1 -- Total Transactions: 1")
			expect(page).to have_content("Name: E 1 -- Total Transactions: 1")
		end

		it "displays a section for incomplete invoices" do
			visit "/admin"
			within("#incomplete-#{@invoice1.id}") do
				expect(page).to have_link("#{@invoice1.id}")
			end
			expect("#{@invoice1.id}").to appear_before("#{@invoice2.id}")
			expect("#{@invoice2.id}").to appear_before("#{@invoice3.id}")
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