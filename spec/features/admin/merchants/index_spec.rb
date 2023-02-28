require 'rails_helper'

RSpec.describe 'admin merchants index page' do
	let!(:merchant1) { create(:merchant)}
	let!(:merchant2) { create(:merchant)}
	let!(:merchant3) { create(:merchant)}
	let!(:merchant4) { create(:merchant)}
	let!(:merchant5) { create(:merchant)}
	let!(:merchant6) { create(:merchant)}

	let!(:item1) {create(:item, merchant: merchant1, name: 'item 1')}
	let!(:item2) {create(:item, merchant: merchant2, name: 'item 2', status: 'enabled')}
	let!(:item3) {create(:item, merchant: merchant3, name: 'item 3')}
	let!(:item4) {create(:item, merchant: merchant4, name: 'item 4')}
	let!(:item5) {create(:item, merchant: merchant5, name: 'item 5')}
	let!(:item6) {create(:item, merchant: merchant6, name: 'item 6')}

	let!(:customer1) { create(:customer)}
	let!(:customer2) { create(:customer)}
	let!(:customer3) { create(:customer)}
	let!(:customer4) { create(:customer)}
	let!(:customer5) { create(:customer)}
	let!(:customer6) { create(:customer)}

	let!(:invoice1) { create(:completed_invoice, customer: customer1, created_at: Date.new(2014, 4, 1))}
	let!(:invoice2) { create(:completed_invoice, customer: customer1,  created_at: Date.new(2012, 3, 2))}
	let!(:invoice3) { create(:completed_invoice, customer: customer2,  created_at: Date.new(2012, 3, 2))} 
	let!(:invoice4) { create(:completed_invoice, customer: customer2,  created_at: Date.new(2012, 3, 2))}
	let!(:invoice5) { create(:completed_invoice, customer: customer3,  created_at: Date.new(2012, 3, 3))}
	let!(:invoice6) { create(:completed_invoice, customer: customer3,  created_at: Date.new(2012, 3, 4))}
	let!(:invoice7) { create(:completed_invoice, customer: customer4,  created_at: Date.new(2012, 3, 3))}
	let!(:invoice8) { create(:completed_invoice, customer: customer5,  created_at: Date.new(2012, 3, 1))}
	let!(:invoice9) { create(:completed_invoice, customer: customer5,  created_at: Date.new(2012, 3, 1))}
	let!(:invoice10) { create(:completed_invoice, customer: customer6,  created_at: Date.new(2012, 3, 2))}
	let!(:invoice11) { create(:completed_invoice, customer: customer6,  created_at: Date.new(2012, 3, 2))}

	let!(:transaction1) {create(:transaction, invoice: invoice1) }
	let!(:transaction2) {create(:transaction, invoice: invoice2) }
	let!(:transaction3) {create(:transaction, invoice: invoice3) }
	let!(:transaction4) {create(:transaction, invoice: invoice4) }
	let!(:transaction5) {create(:transaction, invoice: invoice5) }
	let!(:transaction6) {create(:transaction, invoice: invoice6) }
	let!(:transaction7) {create(:transaction, invoice: invoice8) }
	let!(:transaction8) {create(:transaction, invoice: invoice9) }
	let!(:transaction9) {create(:failed_transaction, invoice: invoice10) }
	let!(:transaction10) {create(:transaction, invoice: invoice10) }
	let!(:transaction11) {create(:transaction, invoice: invoice11) }
	let!(:transaction14) {create(:failed_transaction, invoice: invoice7) }
	let!(:transaction15) {create(:transaction, invoice: invoice7) }

	before do
		create(:invoice_item, item: item1, invoice: invoice1, quantity: 5, unit_price: 6)
		create(:invoice_item, item: item1, invoice: invoice1, quantity: 5, unit_price: 6)
		create(:invoice_item, item: item2, invoice: invoice2, quantity: 4, unit_price: 6)
		create(:invoice_item, item: item2, invoice: invoice2, quantity: 4, unit_price: 6)
		create(:invoice_item, item: item3, invoice: invoice3, quantity: 3, unit_price: 6)
		create(:invoice_item, item: item3, invoice: invoice3, quantity: 3, unit_price: 6)
		create(:invoice_item, item: item4, invoice: invoice4, quantity: 2, unit_price: 6)
		create(:invoice_item, item: item4, invoice: invoice4, quantity: 2, unit_price: 6)
		create(:invoice_item, item: item5, invoice: invoice5, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item5, invoice: invoice5, quantity: 1, unit_price: 6)
		create(:invoice_item, item: item6, invoice: invoice6, quantity: 1, unit_price: 6)
	end
	

	describe 'shows all merchants' do
		it 'shows all merchants' do
			visit "/admin/merchants"

			expect(page).to have_content('Merchants List')
			
			within "#merchant-list" do
				within "##{merchant1.id}" do
					expect(page).to have_content("#{merchant1.name}")
					expect(page).to have_content('Status: active')
				end
				within "##{merchant2.id}" do
					expect(page).to have_content("#{merchant2.name}")
					expect(page).to have_content('Status: active')
				end
				within "##{merchant3.id}" do
					expect(page).to have_content("#{merchant3.name}")
					expect(page).to have_content('Status: active')
				end
			end
		end
	end

	describe 'link to admin/merchant show page' do
		it 'has links on all merchants in admin/merchants to each merchant index' do
			visit "/admin/merchants"

			within "#merchant-list" do
				expect(page).to have_link("#{merchant1.name}", href: admin_merchant_path(merchant1))
				expect(page).to have_link("#{merchant2.name}", href: admin_merchant_path(merchant2))
				expect(page).to have_link("#{merchant3.name}", href: admin_merchant_path(merchant3))
			end
		end

		it 'takes me to admin/merchant show page and I see the merchant name' do
			visit admin_merchants_path
			
			within "#merchant-list" do
				click_link "#{merchant1.name}"
			end 

			expect(current_path).to eq(admin_merchant_path(merchant1))
			expect(page).to have_content("#{merchant1.name}")
			expect(page).to_not have_content("#{merchant2.name}")
		end
	end

	describe 'admin merchant enable/disable' do
		it 'has a button next to each merchant to disable merchant' do
			visit admin_merchants_path

			within "##{merchant1.id}" do
				expect(page).to have_button('Disable')
			end

			within "##{merchant2.id}" do
				expect(page).to have_button('Disable')
			end
		end

		it 'changes status of merchant to disabled when disable button is clicked' do
			visit admin_merchants_path
			
			expect(page).to have_content("#{merchant1.name}\nStatus: active")

			within "##{merchant1.id}" do
				click_button 'Disable'
			end
			
			expect(current_path).to eq(admin_merchants_path)
			expect(page).to have_content("#{merchant1.name}\nStatus: disabled")
		end

		it 'changes status of merchant to enabled when enable button is clicked' do
			visit admin_merchants_path

			within "##{merchant1.id}" do
				expect(page).to have_button('Disable')
				click_button 'Disable'
				expect(page).to have_button('Enable')
			end
			
			expect(page).to have_content("#{merchant1.name}\nStatus: disabled")

			within "##{merchant1.id}" do
				click_button 'Enable'
			end

			expect(current_path).to eq(admin_merchants_path)
			expect(page).to have_content("#{merchant1.name}\nStatus: active")
		end

		it 'will have a link to create a new merchant' do 
			visit admin_merchants_path

			expect(page).to have_link("Create New Merchant")
			click_on "Create New Merchant"

			expect(page).to have_current_path('/admin/merchants/new')
		end

		it 'will have the names of the top 5 merchants by total revenue generated' do 
			visit admin_merchants_path
		
			within "#top_five_merchants_by_rev" do 
				expect(merchant1.name).to appear_before(merchant2.name)
				expect(merchant2.name).to appear_before(merchant3.name)
				expect(merchant3.name).to appear_before(merchant4.name)
				expect(merchant4.name).to appear_before(merchant5.name)
				expect(page).to_not have_content(merchant6.name)
			end 
		end

		it 'will have a link to each merchants admin index page' do 
			visit admin_merchants_path

			within "#top_five_merchants_by_rev" do 
				expect(page).to have_link("#{merchant1.name}")
				expect(page).to have_link("#{merchant2.name}")
				expect(page).to have_link("#{merchant3.name}")
				expect(page).to have_link("#{merchant4.name}")
				expect(page).to have_link("#{merchant5.name}")
			end
		end

		it 'will have the revenues displayed next to each merchants name' do 
			visit admin_merchants_path

			within "#top_five_merchants_by_rev" do 
				expect(page).to have_content("#{merchant1.name} Revenue - $60")
				expect(page).to have_content("#{merchant2.name} Revenue - $48")
				expect(page).to have_content("#{merchant3.name} Revenue - $36")
				expect(page).to have_content("#{merchant4.name} Revenue - $24")
				expect(page).to have_content("#{merchant5.name} Revenue - $12")
			end
		end

		it 'will have a date with the most revenue next to each merchant' do 
			within "#top_five_merchants_by_rev" do 
				expect(page).to have_content("#{merchant1.name} Revenue - $60 - Date With Most Revenue - ")
				expect(page).to have_content("#{merchant2.name} Revenue - $48 - Date With Most Revenue - ")
				expect(page).to have_content("#{merchant3.name} Revenue - $36 - Date With Most Revenue - ")
				expect(page).to have_content("#{merchant4.name} Revenue - $24 - Date With Most Revenue - ")
				expect(page).to have_content("#{merchant5.name} Revenue - $12 - Date With Most Revenue - ")
		end
	end
end