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
		
		@inv1 = @cust1.invoices.create!(status: 1)
		@inv2 = @cust1.invoices.create!(status: 1)
		@inv3 = @cust1.invoices.create!(status: 1)
		@inv4 = @cust2.invoices.create!(status: 1)
		@inv5 = @cust2.invoices.create!(status: 1)
		@inv6 = @cust2.invoices.create!(status: 1)
    
    
		@bowl = @merchant.items.create!(name: "bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @merchant.items.create!(name: "knife", description: "it's a knife", unit_price: 250) 
		@spoon = @merchant.items.create!(name: "spoon", description: "it's a spoon", unit_price: 250) 
		@plate = @merchant.items.create!(name: "plate", description: "it's a plate", unit_price: 250) 
		@fork = @merchant.items.create!(name: "fork", description: "it's a fork", unit_price: 250) 
		@pan = @merchant.items.create!(name: "pan", description: "it's a pan", unit_price: 250) 
		@trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans1_5 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans2 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans3 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans4 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans5 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans6 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans7 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans8 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans9 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans10 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans11 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans12 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans13 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans14 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans15 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
		@trans16 = @inv6.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
    
		InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id)
		InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv2.id)
		InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv3.id)
		InvoiceItem.create!(item_id: @spoon.id, invoice_id: @inv4.id)
		InvoiceItem.create!(item_id: @fork.id, invoice_id: @inv5.id)
		InvoiceItem.create!(item_id: @pan.id, invoice_id: @inv6.id)
	end

	describe 'As a merchant, when I visit my merchant invoices index page' do
		it 'I see all of the invoices that include at least one of my merchants items' do
			visit "/merchants/#{@merchant.id}/invoices"
			expect(page).to have_content("Invoice Id: #{@inv1.id}")
			expect(page).to have_content("Invoice Id: #{@inv2.id}")
			expect(page).to have_content("Invoice Id: #{@inv3.id}")	
		end
		it 'each id links to the merchant invoice show page' do
			visit "/merchants/#{@merchant.id}/invoices"
			expect(page).to have_link("#{@inv1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@inv1.id}")
			expect(page).to have_link("#{@inv2.id}", href: "/merchants/#{@merchant.id}/invoices/#{@inv2.id}")
			expect(page).to have_link("#{@inv3.id}", href: "/merchants/#{@merchant.id}/invoices/#{@inv3.id}")
			
		end
	end
end
