require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
	before(:each) do
		Merchant.destroy_all
		Customer.destroy_all
		Invoice.destroy_all
		Item.destroy_all
		Transaction.destroy_all
		InvoiceItem.destroy_all
		@merchant = Merchant.create!(name: "Carlos Jenkins") 
		@cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
		@cust2 = Customer.create!(first_name: "Bob", last_name: "Fiel")
		@cust3 = Customer.create!(first_name: "John", last_name: "Fiel")
		@cust4 = Customer.create!(first_name: "Tim", last_name: "Fiel")
		@cust5 = Customer.create!(first_name: "Linda", last_name: "Fiel")
		@cust6 = Customer.create!(first_name: "Lucy", last_name: "Fiel")
		@inv1 = @cust1.invoices.create!(status: 1)
		@inv2 = @cust2.invoices.create!(status: 1)
		@inv3 = @cust3.invoices.create!(status: 1)
		@inv4 = @cust4.invoices.create!(status: 1)
		@inv5 = @cust6.invoices.create!(status: 1)
		@inv6 = @cust5.invoices.create!(status: 1)
    
    
		@bowl = @merchant.items.create!(name: "Bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @merchant.items.create!(name: "Knife", description: "it's a knife", unit_price: 250) 
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
    
		@invit1 = InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, status: 1)
		@invit2 =InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv2.id, status: 1)
		@invit3 =InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv3.id, status: 1)
		@invit4 =InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv4.id, status: 0)
		@invit5 =InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv5.id, status: 0)
		@invit6 =InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv6.id, status: 2)
    
    visit "/merchants/#{@merchant.id}/dashboard"
	end
  
  describe 'As a user when I visit my merchant dashboard' do
    it 'I see the name of my merchant' do 

      expect(page).to have_content("Welcome to your dashboard, Carlos Jenkins")
    end

    it 'see link to my merchant items index and merchant invoices index' do 
		
      expect(page).to have_link("My Merchant Items Index", href: "/merchants/#{@merchant.id}")
      expect(page).to have_link("My Merchant Invoices Index", href: "/merchants/#{@merchant.id}/invoices")
    end

    it 'shows the top five customers for that merchant and their number of successful transactions' do 

      expect(page).to have_content "Top Five Customers:"
      expect(page).to have_content "Lucy Fiel -- Transactions: 5"
      expect(page).to have_content "Tim Fiel -- Transactions: 4"
      expect(page).to have_content "John Fiel -- Transactions: 3"
      expect(page).to have_content "Bob Fiel -- Transactions: 2"
      expect(page).to have_content "Laura Fiel -- Transactions: 2"
    end
	end

		describe 'Merchant Dashboard Items Ready to Ship' do
			it 'I see a section for "Items Ready to Ship"' do
				within '#items_to_ship' do
					expect(page).to have_content("Items Ready to Ship")
				end
			end

			it 'In that section I see a list of the names of all of my items that have been ordered and have not yet been shipped' do
				within '#items_to_ship' do
					expect(page).to have_content("Bowl", :count => 4)
					expect(page).to have_content("Knife")
				end
			end

			it 'next to each Item I see the id of the invoice that ordered my item' do
				within '#items_to_ship' do
					expect(page).to have_content(@invit1.invoice_id)
					expect(page).to have_content(@invit2.invoice_id)
					expect(page).to have_content(@invit3.invoice_id)
					expect(page).to have_content(@invit4.invoice_id)
					expect(page).to have_content(@invit5.invoice_id)
				end
			end
			
			it "And each invoice id is a link to my merchant's invoice show page" do
				within '#items_to_ship' do
					expect(page).to have_link("#{@invit1.invoice_id}")
					expect(page).to have_link("#{@invit2.invoice_id}")
					expect(page).to have_link("#{@invit3.invoice_id}")
					expect(page).to have_link("#{@invit4.invoice_id}")
					expect(page).to have_link("#{@invit5.invoice_id}")
				end
					# expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invit1.invoice_id}")
				click_on "#{@invit1.invoice_id}"

				expect(current_path).to eq(merchant_invoice_path(@merchant.id, @invit1.invoice_id))
			end

		it "Next to each Item name I see the date that the invoice was created" do
			within '#items_to_ship' do
				expect(page).to have_content("Bowl created on Thursday, February 23, 2023")
				expect(page).to have_content("Knife created on Thursday, February 23, 2023")
			end
		end

		it 'And I see that the list is ordered from oldest to newest' do 
			within '#items_to_ship' do
			save_and_open_page
				expect("#{@invit1.invoice_id}").to appear_before("#{@invit2.invoice_id}")
				expect("#{@invit3.invoice_id}").to appear_before("#{@invit4.invoice_id}")
				expect("#{@invit3.invoice_id}").to_not appear_before("#{@invit1.invoice_id}")
			end
		end
	end
end