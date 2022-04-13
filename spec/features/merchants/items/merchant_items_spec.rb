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

    it 'lists enabled and disabled items in thier own section' do
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

        expect(page).to have_content("Top Items")

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
