require 'rails_helper'

RSpec.describe 'merchant items index page', type: :feature do
  describe "as a merchant, when I visit my merchant index page ('/merchant/merchant_id/items')" do
    let!(:merchant1) { create(:merchant)}
    let!(:merchant2) { create(:merchant)}

    let!(:item1) {create(:item, merchant: merchant1, name: 'item 1')}
    let!(:item2) {create(:item, merchant: merchant1, name: 'item 2', status: 'enabled')}
    let!(:item3) {create(:item, merchant: merchant1, name: 'item 3')}
    let!(:item4) {create(:item, merchant: merchant1, name: 'item 4')}
    let!(:item5) {create(:item, merchant: merchant1, name: 'item 5')}
    let!(:item6) {create(:item, merchant: merchant2, name: 'item 6')}
    let!(:item7) {create(:item, merchant: merchant1, name: 'item 7')}

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
		let!(:transaction11) {create(:transaction, invoice: invoice11) }
		let!(:transaction14) {create(:failed_transaction, invoice: invoice7) }
		let!(:transaction15) {create(:transaction, invoice: invoice7) }
    
    before do
			create(:invoice_item, item: item1, invoice: invoice2, quantity: 1, unit_price: 1)
			create(:invoice_item, item: item1, invoice: invoice1, quantity: 1, unit_price: 1)
			create(:invoice_item, item: item1, invoice: invoice4, quantity: 1, unit_price: 1)
			create(:invoice_item, item: item1, invoice: invoice5, quantity: 1, unit_price: 1)
			create(:invoice_item, item: item1, invoice: invoice8, quantity: 1, unit_price: 1)
			create(:invoice_item, item: item1, invoice: invoice11, quantity: 1, unit_price: 1)
	
			create(:invoice_item, item: item2, invoice: invoice1, quantity: 2, unit_price: 1)
			create(:invoice_item, item: item2, invoice: invoice5, quantity: 2, unit_price: 1)
			create(:invoice_item, item: item2, invoice: invoice9, quantity: 2, unit_price: 1)
			create(:invoice_item, item: item2, invoice: invoice6, quantity: 1, unit_price: 1)
	
			create(:invoice_item, item: item3, invoice: invoice8, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item3, invoice: invoice9, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item3, invoice: invoice10, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item3, invoice: invoice3, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item3, invoice: invoice6, quantity: 2, unit_price: 6)
	
			create(:invoice_item, item: item4, invoice: invoice10, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item4, invoice: invoice11, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item4, invoice: invoice2, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item4, invoice: invoice3, quantity: 1, unit_price: 6)
			create(:invoice_item, item: item4, invoice: invoice4, quantity: 1, unit_price: 6)
	
			create(:invoice_item, item: item5, invoice: invoice7, quantity: 3, unit_price: 6)
			create(:invoice_item, item: item5, invoice: invoice3, quantity: 1, unit_price: 1)

			create(:invoice_item, item: item6, invoice: invoice3, quantity: 2, unit_price: 1)
    end

    it "I see a list of the names of all the items and do not see other merchant items" do
      visit "/merchants/#{merchant1.id}/items"

      expect(page).to have_content(item1.name)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item3.name)
      expect(page).to have_content(item4.name)
      expect(page).to have_content(item5.name)

      expect(page).to_not have_content(item6.name)
    end

    it 'has a buttom next to each item to disable or enable that item' do
      visit "/merchants/#{merchant1.id}/items"

      within "##{item1.id}" do 
        expect(page).to have_content(item1.name)
        expect(page).to have_button("Enable")
      end

      within "##{item2.id}" do 
        expect(page).to have_content(item2.name)
        expect(page).to have_button("Disable")
      end
    end

    it 'changes the status when I click the buttom and redirects back to items index' do
      visit "/merchants/#{merchant1.id}/items"

      within "##{item1.id}" do 
        expect(page).to have_button("Enable")

        click_button

        expect(page).to have_button("Disable")
      end
    end
		
		describe 'enable/disabled sections on page' do
			it 'seperate enabled section' do
				visit merchant_items_path(merchant1)

				within "#enabled_items" do
					expect(page).to have_content(item2.name)
					expect(page).to_not have_content(item1.name)
					expect(page).to_not have_content(item3.name)
					expect(page).to_not have_content(item4.name)
					expect(page).to_not have_content(item5.name)
					
					within "##{item2.id}" do 
						click_button
					end
					
					expect(page).to_not have_content(item2.name)
				end
			end

			it 'seperate disabled section' do
				visit merchant_items_path(merchant1)
				
				within "#disabled_items" do
					expect(page).to_not have_content(item2.name)
					expect(page).to have_content(item1.name)
					expect(page).to have_content(item3.name)
					expect(page).to have_content(item4.name)
					
					within "##{item3.id}" do 
						click_button
					end

					expect(page).to_not have_content(item3.name)
				end
			end
		end

		describe 'create new item' do
			it 'has a link to create a new item for merchant' do
				visit merchant_items_path(merchant1)

				expect(page).to have_link("New Item")
			end

			it 'when new item link is clicked it takes us to new item page' do
				visit merchant_items_path(merchant1)

				click_link 'New Item'
				
				expect(current_path).to eq(new_merchant_item_path(merchant1))
			end
		end

		describe 'Top 5 Most Popular Items' do
			it 'has a section that shows the 5 most popular items' do
				visit merchant_items_path(merchant1)
				
				within '#top_5_most_popular_items' do
					expect(item3.name).to appear_before(item4.name)
					expect(item4.name).to appear_before(item5.name)
					expect(item5.name).to appear_before(item2.name)
					expect(item2.name).to appear_before(item1.name)
					expect(page).to_not have_content(item6.name)
				end
			end

			it 'has links to merchant item show page for each item' do
				visit merchant_items_path(merchant1)

				within '#top_5_most_popular_items' do
					expect(page).to have_link(item3.name)
					expect(page).to have_link(item4.name)
					expect(page).to have_link(item5.name)
					expect(page).to have_link(item2.name)
					expect(page).to have_link(item1.name)
				end
			end

			it 'has total revenue shown next to the item' do
				visit merchant_items_path(merchant1)
				
				within "#top_5_most_popular_items" do
					within "##{item3.id}_popular_item" do
						expect(page).to have_content("$30 in sales")
					end
					within "##{item4.id}_popular_item" do
						expect(page).to have_content("$24 in sales")
					end
					within "##{item5.id}_popular_item" do
						expect(page).to have_content("$19 in sales")
					end
					within "##{item2.id}_popular_item" do
						expect(page).to have_content("$7 in sales")
					end
					within "##{item1.id}_popular_item" do
						expect(page).to have_content("$6 in sales")
					end
				end
			end

			it 'has date with most sales shown next to the item' do
				visit merchant_items_path(merchant1)

				within "#top_5_most_popular_items" do
					within "##{item3.id}_popular_item" do
						expect(page).to have_content("Top day for #{item3.name} was 03/01/2012")
					end
					within "##{item4.id}_popular_item" do
						expect(page).to have_content("Top day for #{item4.name} was 03/02/2012")
					end
					within "##{item5.id}_popular_item" do
						expect(page).to have_content("Top day for #{item5.name} was 03/03/2012")
					end
					within "##{item2.id}_popular_item" do
						expect(page).to have_content("Top day for #{item2.name} was 04/01/2014")
					end
					within "##{item1.id}_popular_item" do
						expect(page).to have_content("Top day for #{item1.name} was 03/02/2012")
					end
				end
			end
		end
  end
end