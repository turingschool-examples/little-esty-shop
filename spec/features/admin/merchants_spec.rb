require "rails_helper"

RSpec.describe "As an admin" do
	before :each do
		@mer_1 = create(:merchant)
		@mer_2 = create(:merchant)
		@mer_3 = create(:merchant)
		@mer_4 = create(:merchant)
		@mer_5 = create(:merchant)
		@cust_1 = create(:customer, first_name: "A", last_name: "1")
		@cust_2 = create(:customer, first_name: "B", last_name: "1")
		@cust_3 = create(:customer, first_name: "C", last_name: "1")
		@cust_4 = create(:customer, first_name: "D", last_name: "1")
				@item_1 = create(:item, merchant_id: @mer_1.id)
		@item_2 = create(:item, merchant_id: @mer_1.id)
		@item_3 = create(:item, merchant_id: @mer_1.id)
		@item_4 = create(:item, merchant_id: @mer_1.id)
				@item_5 = create(:item, merchant_id: @mer_2.id)
		@item_6 = create(:item, merchant_id: @mer_2.id)
		@item_7 = create(:item, merchant_id: @mer_2.id)
		@item_8 = create(:item, merchant_id: @mer_2.id)
				@item_9 = create(:item, merchant_id: @mer_3.id)
		@item_10 = create(:item, merchant_id: @mer_3.id)
		@item_11 = create(:item, merchant_id: @mer_3.id)
		@item_12 = create(:item, merchant_id: @mer_3.id)
				@item_13 = create(:item, merchant_id: @mer_4.id)
		@item_14 = create(:item, merchant_id: @mer_4.id)
		@item_15 = create(:item, merchant_id: @mer_4.id)
		@item_16 = create(:item, merchant_id: @mer_4.id)
				@item_17 = create(:item, merchant_id: @mer_5.id)
		@item_18 = create(:item, merchant_id: @mer_5.id)
		@item_19 = create(:item, merchant_id: @mer_5.id)
		@item_20 = create(:item, merchant_id: @mer_5.id)
		
		@invoice1 = create(:invoice, customer_id: @cust_1.id)
		@invoice2 = create(:invoice, customer_id: @cust_2.id)
		@invoice3 = create(:invoice, customer_id: @cust_3.id)
		@invoice4 = create(:invoice, customer_id: @cust_4.id)
		@invoice_item1 = create(:invoice_item, status: 0 ,item_id:@item_1.id, invoice_id:@invoice1.id)
		@invoice_item2 = create(:invoice_item, status: 0 , item_id:@item_2.id, invoice_id:@invoice2.id)
		@invoice_item3 = create(:invoice_item, status: 0 , item_id:@item_3.id, invoice_id:@invoice3.id)
		@invoice_item4 = create(:invoice_item, item_id:@item_4.id, invoice_id:@invoice4.id)
				@invoice_item11 = create(:invoice_item, status: 0 ,item_id:@item_5.id, invoice_id:@invoice1.id)
		@invoice_item12 = create(:invoice_item, status: 0 , item_id:@item_6.id, invoice_id:@invoice2.id)
		@invoice_item13 = create(:invoice_item, status: 0 , item_id:@item_7.id, invoice_id:@invoice3.id)
		@invoice_item14 = create(:invoice_item, item_id:@item_8.id, invoice_id:@invoice4.id)
				@invoice_item21 = create(:invoice_item, status: 0 ,item_id:@item_9.id, invoice_id:@invoice1.id)
		@invoice_item22 = create(:invoice_item, status: 0 , item_id:@item_10.id, invoice_id:@invoice2.id)
		@invoice_item23 = create(:invoice_item, status: 0 , item_id:@item_11.id, invoice_id:@invoice3.id)
		@invoice_item24 = create(:invoice_item, item_id:@item_12.id, invoice_id:@invoice4.id)
				@invoice_item31 = create(:invoice_item, status: 0 ,item_id:@item_13.id, invoice_id:@invoice1.id)
		@invoice_item32 = create(:invoice_item, status: 0 , item_id:@item_14.id, invoice_id:@invoice2.id)
		@invoice_item33 = create(:invoice_item, status: 0 , item_id:@item_15.id, invoice_id:@invoice3.id)
		@invoice_item34 = create(:invoice_item, item_id:@item_16.id, invoice_id:@invoice4.id)
				@invoice_item41 = create(:invoice_item, status: 0 ,item_id:@item_17.id, invoice_id:@invoice1.id)
		@invoice_item42 = create(:invoice_item, status: 0 , item_id:@item_18.id, invoice_id:@invoice2.id)
		@invoice_item43 = create(:invoice_item, status: 0 , item_id:@item_19.id, invoice_id:@invoice3.id)
		@invoice_item44 = create(:invoice_item, item_id:@item_20.id, invoice_id:@invoice4.id)
		
		@transaction1 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "failed", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction3 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction4 = create(:transaction, result: "success", invoice_id: @invoice4.id)
		@transaction6 = create(:transaction, result: "success", invoice_id: @invoice3.id)
		@transaction7 = create(:transaction, result: "success", invoice_id: @invoice3.id)
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

		it "shows the top 5 merchants" do
			visit "/admin/merchants"
			expect(@mer_1.name).to appear_before(@mer_2.name)
			expect(@mer_2.name).to appear_before(@mer_3.name)
			expect(@mer_3.name).to appear_before(@mer_4.name)
			expect(@mer_4.name).to appear_before(@mer_5.name)

		end

		it "shows the best dates for the top 5 merchants" do
			# today = mock
			# Date.expects(:today).returns(today)
			# today.expects(:strftime).returns("030121")
			#TODO: how the damn hell do we mock and stub datetime for testing
			visit "/admin/merchants"

			expect(page).to have_content("Top selling date for #{@mer_1.name}")
			expect(page).to have_content("Top selling date for #{@mer_2.name}")
			expect(page).to have_content("Top selling date for #{@mer_3.name}")
			expect(page).to have_content("Top selling date for #{@mer_4.name}")
			expect(page).to have_content("Top selling date for #{@mer_5.name}")
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