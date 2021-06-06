require 'rails_helper'

RSpec.describe 'items index page' do
  before :each do
    @frank = Customer.create!(first_name: 'Frank', last_name: 'Enstein')

    @invoice_1 = @frank.invoices.create!(status: 2)
    @invoice_2 = @frank.invoices.create!(status: 2)
    @invoice_3 = @frank.invoices.create!(status: 2)

    @merchant_1 = Merchant.create!(name: 'LittleHomeSlice')
    @item_1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant_1.id, status: 1)
    @item_2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant_1.id, status: 1)
    @item_3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant_1.id, status: 1)

    @merchant_2 = Merchant.create!(name: 'BreadNButter')
    @item_4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.0, merchant_id: @merchant_2.id, status: 0)
    @item_5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.5, merchant_id: @merchant_2.id, status: 0)
    @item_6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.0, merchant_id: @merchant_2.id, status: 0)
    @item_7 = Item.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 11.5, merchant_id: @merchant_2.id, status: 0)
    @item_8 = Item.create!(name: 'Thing 8', description: 'This is the eighth thing.', unit_price: 18.0, merchant_id: @merchant_2.id, status: 0)
    @item_9 = Item.create!(name: 'Thing 9', description: 'This is the ninth thing.', unit_price: 17.0, merchant_id: @merchant_2.id, status: 0)
    @item_10 = Item.create!(name: 'Thing 10', description: 'This is the tenth thing.', unit_price: 21.0, merchant_id: @merchant_2.id, status: 0)
    @invoice_item_0 = @item_4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice_id: @invoice_1.id) #96.0  1
    @invoice_item_1 = @item_4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice_id: @invoice_2.id) #96.0  1
    @invoice_item_2 = @item_5.invoice_items.create!(quantity: 3, unit_price: 15.5, status: 2, invoice_id: @invoice_1.id) #46.5  4
    @invoice_item_3 = @item_6.invoice_items.create!(quantity: 7, unit_price: 10.0, status: 2, invoice_id: @invoice_2.id) #70.0  3
    @invoice_item_4 = @item_7.invoice_items.create!(quantity: 4, unit_price: 11.5, status: 2, invoice_id: @invoice_2.id) #46.0  5
    @invoice_item_5 = @item_8.invoice_items.create!(quantity: 1, unit_price: 18.0, status: 2, invoice_id: @invoice_3.id) #18.0
    @invoice_item_6 = @item_9.invoice_items.create!(quantity: 5, unit_price: 17.0, status: 2, invoice_id: @invoice_2.id) #85.0  2
    @invoice_item_7 = @item_10.invoice_items.create!(quantity: 2, unit_price: 21.0, status: 2, invoice_id: @invoice_3.id) #42.0
    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 1234432198766789, result: 1)
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 9874632145631456, result: 1)
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 2587147896329852, result: 0)
  end

  describe 'item names' do
    it 'can list the names of all the items for that merchant' do
      visit "/merchants/#{@merchant_1.id}/items"

      within "#enabled-items-#{@item_2.id}" do
        expect(page).to have_link(@item_2.name)
        expect(page).to_not have_link(@item_5.name)
      end

      within "#enabled-items-#{@item_3.id}" do
        expect(page).to have_link(@item_3.name)
        expect(page).to_not have_link(@item_6.name)
      end
    end

    it 'has the item names listed as links' do
      visit "/merchants/#{@merchant_2.id}/items"

      within "#disabled-items-#{@item_4.id}" do
        expect(page).to have_link(@item_4.name)
        click_link "#{@item_4.name}"
        expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/#{@item_4.id}")
      end
    end
  end

  describe 'create' do
    it 'has a link to create a new item' do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_button("Create New Item")
    end

    it 'takes the user to the new page' do
      visit "/merchants/#{@merchant_2.id}/items"

      click_button "Create New Item"

      expect(current_path).to eq("/merchants/#{@merchant_2.id}/items/new")
    end
  end

  describe 'enable/disable' do
    it 'has a button to enable an item' do
      visit "/merchants/#{@merchant_2.id}/items"

      within "#disabled-items-#{@item_4.id}" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      within "#disabled-items-#{@item_5.id}" do
        expect(page).to have_content(@item_5.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      within "#disabled-items-#{@item_6.id}" do
        expect(page).to have_content(@item_6.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end
    end

    it 'has a button to disable an item' do
      visit "/merchants/#{@merchant_1.id}/items"

      within "#enabled-items-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      within "#enabled-items-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      within "#enabled-items-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end
    end
  end

  describe 'top 5 most popular items' do
    it 'can list the top 5 most popluar items' do
      visit "/merchants/#{@merchant_2.id}/items"

      expect(page).to have_content("Top Items")
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_5.name)
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
# Only invoices with at least one successful transation should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
