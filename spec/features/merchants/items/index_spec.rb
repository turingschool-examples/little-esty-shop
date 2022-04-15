require 'rails_helper'

RSpec.describe 'Merchant items index' do
  before do
    @starw = Merchant.create!(name: "Star Wars R Us ")
    @start = Merchant.create!(name: "Star Trek R Us ")

    @item1 = @starw.items.create!(name:	"X-wing",
                          description: "X-wing ship",
                          unit_price:75107,
                          status: 1
                         )

    @item2 = @starw.items.create!(name:	"Tie-fighter",
                          description: "Tie-fighter ship",
                          unit_price:75000,
                          status: 0
                         )
    @item3 = @starw.items.create!(name:	"Lightsaber",
                          description: "Lightsaber",
                          unit_price:7500,
                          status: 1
                         )

    @item4 = @starw.items.create!(name:	"Luke",
                          description: "Luke SKywalker figure",
                          unit_price:1000
                         )

    visit "/merchants/#{@starw.id}/items"
  end

  describe 'Displays' do
    it 'lists names of all merchant items' do

#      save_and_open_page
      expect(page).to have_current_path("/merchants/#{@starw.id}/items")
      expect(page).to have_content(@starw.name)
      expect(page).to_not have_content(@start.name)

    end

    it 'lists enabled and disabled items in their own section' do
      expect(page).to have_current_path("/merchants/#{@starw.id}/items")

      within "#enabled-#{@starw.id}" do
        expect(page).to have_content("Enabled Items")
        expect(page).to have_content(@item1.name)
        expect(page).to_not have_content(@item2.name)
      end

      within "#disabled-#{@starw.id}" do
        expect(page).to have_content("Disabled Items")
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end

    it 'has and links to create a new item' do
       expect(page).to have_button("Create New Item")

       click_button("Create New Item")
       expect(current_path).to eq(new_merchant_item_path(@starw))

    end

    it 'lists the names of the top 5 most popular items ranked by total revenue' do

        expect(page).to have_content("Top 5 Items")

        merchant1 = create(:merchant)
        merchant2 = create(:merchant)

        customer1 = create(:customer)

        invoice1 = create(:invoice, customer: customer1, status: 1)
        invoice2 = create(:invoice, customer: customer1, status: 1)

        transaction1 = create(:transaction, invoice: invoice1, result: 'success')
        transaction2 = create(:transaction, invoice: invoice1, result: 'failed')

        item1 = create(:item, merchant: merchant1, unit_price: 300)
        item2 = create(:item, merchant: merchant1, unit_price: 15)
        item3 = create(:item, merchant: merchant1, unit_price: 15)
        item4 = create(:item, merchant: merchant1, unit_price: 15)
        item5 = create(:item, merchant: merchant1, unit_price: 15)
        item6 = create(:item, merchant: merchant1, unit_price: 15)

        invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 1, unit_price: 300) #300 rev
        invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 2, unit_price: 10) #20 rev
        invoice_item3 = create(:invoice_item, item: item3, invoice: invoice1, quantity: 3, unit_price: 10) #30 rev
        invoice_item4 = create(:invoice_item, item: item4, invoice: invoice1, quantity: 1, unit_price: 10) #10 rev
        invoice_item5 = create(:invoice_item, item: item5, invoice: invoice2, quantity: 5, unit_price: 10) #50 rev
        invoice_item6 = create(:invoice_item, item: item6, invoice: invoice2, quantity: 2, unit_price: 10) #20 rev
    end
  end
end
# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name
#
# Notes on Revenue Calculation:
#
# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied
# by the quantity (do not use the item unit price)
