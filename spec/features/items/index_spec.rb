require 'rails_helper'

RSpec.describe 'items index page' do
  before :each do
    @frank = Customer.create!(first_name: 'Frank', last_name: 'Enstein')

    @invoice1 = @frank.invoices.create!(status: 2)
    @invoice2 = @frank.invoices.create!(status: 2)
    @invoice3 = @frank.invoices.create!(status: 2)

    @merchant1 = Merchant.create!(name: 'LittleHomeSlice')
    @item1 = Item.create!(name: 'Thing 1', description: 'This is the first thing.', unit_price: 14.9, merchant_id: @merchant1.id, status: 1)
    @item2 = Item.create!(name: 'Thing 2', description: 'This is the second thing.', unit_price: 16.3, merchant_id: @merchant1.id, status: 1)
    @item3 = Item.create!(name: 'Thing 3', description: 'This is the third thing.', unit_price: 19.4, merchant_id: @merchant1.id, status: 1)

    @merchant2 = Merchant.create!(name: 'BreadNButter')
    @item4 = Item.create!(name: 'Thing 4', description: 'This is the fourth thing.', unit_price: 12.0, merchant_id: @merchant2.id, status: 0)
    @item5 = Item.create!(name: 'Thing 5', description: 'This is the fifth thing.', unit_price: 15.5, merchant_id: @merchant2.id, status: 0)
    @item6 = Item.create!(name: 'Thing 6', description: 'This is the sixth thing.', unit_price: 10.0, merchant_id: @merchant2.id, status: 0)
    @item7 = Item.create!(name: 'Thing 7', description: 'This is the seventh thing.', unit_price: 11.5, merchant_id: @merchant2.id, status: 0)
    @item8 = Item.create!(name: 'Thing 8', description: 'This is the eighth thing.', unit_price: 18.0, merchant_id: @merchant2.id, status: 0)
    @item9 = Item.create!(name: 'Thing 9', description: 'This is the ninth thing.', unit_price: 17.0, merchant_id: @merchant2.id, status: 0)
    @item10 = Item.create!(name: 'Thing 10', description: 'This is the tenth thing.', unit_price: 21.0, merchant_id: @merchant2.id, status: 0)
    @invoice_item0 = @item4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice_id: @invoice1.id) #96.0  1
    @invoice_item1 = @item4.invoice_items.create!(quantity: 4, unit_price: 12.0, status: 2, invoice_id: @invoice2.id) #96.0  1
    @invoice_item2 = @item5.invoice_items.create!(quantity: 3, unit_price: 15.5, status: 2, invoice_id: @invoice1.id) #46.5  4
    @invoice_item3 = @item6.invoice_items.create!(quantity: 7, unit_price: 10.0, status: 2, invoice_id: @invoice2.id) #70.0  3
    @invoice_item4 = @item7.invoice_items.create!(quantity: 4, unit_price: 11.5, status: 2, invoice_id: @invoice2.id) #46.0  5
    @invoice_item5 = @item8.invoice_items.create!(quantity: 1, unit_price: 18.0, status: 2, invoice_id: @invoice3.id) #18.0
    @invoice_item6 = @item9.invoice_items.create!(quantity: 5, unit_price: 17.0, status: 2, invoice_id: @invoice2.id) #85.0  2
    @invoice_item7 = @item10.invoice_items.create!(quantity: 2, unit_price: 21.0, status: 2, invoice_id: @invoice3.id) #42.0
    @transaction1 = @invoice1.transactions.create!(credit_card_number: 1234432198766789, result: 1)
    @transaction2 = @invoice2.transactions.create!(credit_card_number: 9874632145631456, result: 1)
    @transaction3 = @invoice3.transactions.create!(credit_card_number: 2587147896329852, result: 0)
  end

  describe 'item names' do
    it 'can list the names of all the items for that merchant' do
      visit "/merchants/#{@merchant1.id}/items"

      within "#enabled-items-#{@item2.id}" do
        expect(page).to have_link(@item2.name)
        expect(page).to_not have_link(@item5.name)
      end

      within "#enabled-items-#{@item3.id}" do
        expect(page).to have_link(@item3.name)
        expect(page).to_not have_link(@item6.name)
      end
    end

    it 'has the item names listed as links' do
      visit "/merchants/#{@merchant2.id}/items"

      within "#disabled-items-#{@item4.id}" do
        expect(page).to have_link(@item4.name)
        click_link "#{@item4.name}"
        expect(current_path).to eq("/merchants/#{@merchant2.id}/items/#{@item4.id}")
      end
    end
  end

  describe 'create' do
    it 'has a link to create a new item' do
      visit "/merchants/#{@merchant1.id}/items"

      expect(page).to have_button("Create New Item")
    end

    it 'takes the user to the new page' do
      visit "/merchants/#{@merchant2.id}/items"

      click_button "Create New Item"

      expect(current_path).to eq("/merchants/#{@merchant2.id}/items/new")
    end
  end

  describe 'enable/disable' do
    it 'has a button to enable an item' do
      visit "/merchants/#{@merchant2.id}/items"

      within "#disabled-items-#{@item4.id}" do
        expect(page).to have_content(@item4.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      within "#disabled-items-#{@item5.id}" do
        expect(page).to have_content(@item5.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      within "#disabled-items-#{@item6.id}" do
        expect(page).to have_content(@item6.name)
        expect(page).to have_button("Enable")
        click_button "Enable"
      end
    end

    it 'has a button to disable an item' do
      visit "/merchants/#{@merchant1.id}/items"

      within "#enabled-items-#{@item1.id}" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      within "#enabled-items-#{@item2.id}" do
        expect(page).to have_content(@item2.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      within "#enabled-items-#{@item3.id}" do
        expect(page).to have_content(@item3.name)
        expect(page).to have_button("Disable")
        click_button "Disable"
      end
    end
  end

  describe 'top 5 most popular items' do
    it 'can list the top 5 most popluar items' do
      visit "/merchants/#{@merchant2.id}/items"

      expect(page).to have_content("Top Items")
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item5.name)
    end

    it 'can list the most popluar day for each item' do
      visit "/merchants/#{@merchant2.id}/items"

      expect(page).to have_content("#{@item4.created_at.strftime("%m/%d/%Y")}")
    end
  end
end
