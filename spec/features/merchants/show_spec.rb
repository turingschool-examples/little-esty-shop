require 'rails_helper'

RSpec.describe 'merchant show page' do
	before :each do
		@merchant1 = Merchant.create!(name: "Schroeder-Jerde")
		@merchant2 = Merchant.create!(name: "Schroeder-Jerde_2")
	end

	it 'displays the merchant name' do
		visit "/merchants/#{@merchant1.id}/dashboard"

		expect(page).to have_content(@merchant1.name)
		expect(page).to_not have_content(@merchant2.name)
	end

	it "has a link to the merchant item index" do
		visit "/merchants/#{@merchant1.id}/dashboard"
		click_link "My Items"

		expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
	end

	it "has a link to the merchant invoice index" do
		visit "/merchants/#{@merchant1.id}/dashboard"
		click_link "My Invoices"

		expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
	end

	it 'has an Items ready to ship section and lists items not yet been shipped' do 
		@item1 = @merchant1.items.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est lauda...", unit_price: 75107)
		@item2 = @merchant1.items.create!(name: "Item Autem Minima", description: "Cumque consequuntur ad. Fuga tenetur illo molestia...", unit_price: 67076)
		@item3 = @merchant1.items.create!(name: "Item Ea Voluptatum", description: "Sunt officia eum qui molestiae. Nesciunt quidem cu...", unit_price: 32301)
		@customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
		@invoice1 = Invoice.create!(customer_id: @customer1.id, status: 0)
		@invoice2 = Invoice.create!(customer_id: @customer1.id, status: 1)
		@invoice3 = Invoice.create!(customer_id: @customer1.id, status: 2)
		@invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 75100, status: "shipped",)
		@invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 200000, status: "packaged",)
		@invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 1, unit_price: 32301, status: "pending",)

		visit "/merchants/#{@merchant1.id}/dashboard"
		
		within('#items_to_ship') do 
			expect(page).to have_content('Items Ready to Ship:')
			expect(page).to have_content(@item2.name)
			expect(page).to have_content(@invoice_item2.invoice_id)
			expect(page).to have_content(@item3.name)
			expect(page).to have_content(@invoice_item3.invoice_id)
			expect(page).to_not have_content(@item1.name)
			expect(page).to_not have_content(@invoice_item1.invoice_id)
		end
	end
	it 'items_ready_to_ship section shows invoice created_at date with weekday, mon, date, year format' do 
		@item1 = @merchant1.items.create!(name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est lauda...", unit_price: 75107)
		@customer1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
		@invoice1 = Invoice.create!(customer_id: @customer1.id, status: 0)
		@invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 75100, status: "pending",)

		visit "/merchants/#{@merchant1.id}/dashboard"
		within('#items_to_ship') do 
			expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %-d, %Y"))
		end
	end
end
