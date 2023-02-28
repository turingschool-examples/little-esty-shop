require 'rails_helper'

RSpec.describe 'Merchant Invoices Index' do
  before (:each) do
		Merchant.destroy_all
		Customer.destroy_all
		Invoice.destroy_all
		Item.destroy_all
		Transaction.destroy_all
		InvoiceItem.destroy_all
		@merchant = Merchant.create!(name: "Carlos Jenkins") 
		@cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
		@cust2 = Customer.create!(first_name: "Bob", last_name: "Fiel")
		
		@inv1 = @cust1.invoices.create!(status: 1, created_at: "2023-02-27 09:54:09")
		@inv2 = @cust1.invoices.create!(status: 1, created_at: "2023-02-27 09:54:09")
		
		@bowl = @merchant.items.create!(name: "bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @merchant.items.create!(name: "knife", description: "it's a knife", unit_price: 250) 
		@plate = @merchant.items.create!(name: "plate", description: "it's a plate", unit_price: 250) 
		
		@trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans2 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, quantity: 10, unit_price: 350, status: 1)
		InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id, quantity: 5, unit_price: 300, status: 1)
		InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv1.id, quantity: 3, unit_price: 200, status: 1)

		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv2.id, quantity: 20, unit_price: 350, status: 1)
		InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv2.id, quantity: 10, unit_price: 300, status: 1)
		InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv2.id, quantity: 6, unit_price: 200, status: 1)
	end

	describe 'As a merchant, when I visit my merchant invoices show page' do
		it 'Then I see information related to that invoice' do
			visit "/merchants/#{@merchant.id}/invoices/#{@inv1.id}"

			expect(page).to have_content("Invoice ID: #{@inv1.id}")
			expect(page).to_not have_content("Invoice ID: #{@inv2.id}")
			expect(page).to have_content("Invoice Status: #{@inv1.status}")
			expect(page).to have_content("Invoice Created at: Monday, February 27, 2023")
			expect(page).to have_content("Customer: Laura Fiel")
			expect(page).to_not have_content("Customer: Bob Fiel")
		end

		it 'Then I see all of my items on the invoice' do
			visit "/merchants/#{@merchant.id}/invoices/#{@inv1.id}"
			
			within "div#invoice_item-#{@bowl.id}" do
				expect(page).to have_content("Item: bowl")
				expect(page).to have_content("Quantity: 10")
				expect(page).to have_content("Price: $3.50")
			end
		end

		it 'I see the total revenue that will be generated from all of my items on the invoice' do
			visit "/merchants/#{@merchant.id}/invoices/#{@inv1.id}"
				expect(page).to have_content("Total Revenue: $56.00")	

			visit "/merchants/#{@merchant.id}/invoices/#{@inv2.id}"
				expect(page).to have_content("Total Revenue: $112.00")				
		end

		############################US18####################################
		describe 'user_story_18' do
			before :each do
				visit merchant_invoice_path(@merchant.id, @inv1.id)
			end

			it 'see that each invoice item status is a select field' do

				expect(page).to have_select(:invoice_item_status)    
			end

			describe 'when i click this select field' do
				it "I can select a new status for the Item" do
					within "#invoice_item-#{@bowl.id}" do
						select 'shipped', from: :invoice_item_status
		
						expect(page).to have_select(:invoice_item_status, selected: "shipped")
					end
				end
	
				it "next to the select field I see a button to 'Update Item Status'" do
					within "#invoice_item-#{@bowl.id}" do
						select 'shipped', from: :invoice_item_status
		
						expect(page).to have_button('Update Item Status')
					end
				end
			end
	
			describe 'when i click the update button' do
				it 'I am taken back to the invoice show page' do
				  within "#invoice_item-#{@bowl.id}" do
						select 'shipped', from: :invoice_item_status
						click_button 'Update Item Status'
						expect(page.current_path).to eq(merchant_invoice_path(@merchant.id, @inv1.id))
					end
				end
	
				it "I see that my Items's status has now been updated" do
					within "#invoice_item-#{@bowl.id}" do
						select 'shipped', from: :invoice_item_status
						click_button 'Update Item Status'

						expect(page).to have_select(:invoice_item_status, selected: "shipped")
					end

					expect(page).to have_content('Item Status has been updated successfully')
				end
			end
		end

	end
end
