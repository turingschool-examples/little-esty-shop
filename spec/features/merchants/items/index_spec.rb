require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    test_data
    @item_11 = Item.create!(name: "Item 11", description: "Item 11 description", unit_price: 1700, merchant: @merchant_1)
    @item_12 = Item.create!(name: "Item 12", description: "Item 12 description", unit_price: 1800, merchant: @merchant_1)
    @item_13 = Item.create!(name: "Item 13", description: "Item 13 description", unit_price: 1900, merchant: @merchant_1)
    @item_14 = Item.create!(name: "Item 14", description: "Item 14 description", unit_price: 1200, merchant: @merchant_1)
    @item_15 = Item.create!(name: "Item 15", description: "Item 15 description", unit_price: 1600, merchant: @merchant_1)
    @item_16 = Item.create!(name: "Item 16", description: "Item 16 description", unit_price: 2100, merchant: @merchant_2)
    @item_17 = Item.create!(name: "Item 17", description: "Item 17 description", unit_price: 3100, merchant: @merchant_2)
    @item_18 = Item.create!(name: "Item 18", description: "Item 18 description", unit_price: 44100, merchant: @merchant_2)
    @item_19 = Item.create!(name: "Item 19", description: "Item 19 description", unit_price: 13600, merchant: @merchant_2)
    @item_20 = Item.create!(name: "Item 20", description: "Item 20 description", unit_price: 13200, merchant: @merchant_2)

    @invoice_item_21 = InvoiceItem.create!(quantity: 40, unit_price: 1700, status: "packaged", item: @item_11, invoice: @invoice_1)
    @invoice_item_22 = InvoiceItem.create!(quantity: 12, unit_price: 1800, status: "packaged", item: @item_12, invoice: @invoice_1)
    @invoice_item_23 = InvoiceItem.create!(quantity: 10, unit_price: 1900, status: "packaged", item: @item_13, invoice: @invoice_1)
    @invoice_item_24 = InvoiceItem.create!(quantity: 20, unit_price: 1200, status: "packaged", item: @item_14, invoice: @invoice_1)
    @invoice_item_25 = InvoiceItem.create!(quantity: 30, unit_price: 1600, status: "packaged", item: @item_15, invoice: @invoice_1)
    @invoice_item_26 = InvoiceItem.create!(quantity: 40, unit_price: 2100, status: "packaged", item: @item_16, invoice: @invoice_2)
    @invoice_item_27 = InvoiceItem.create!(quantity: 12, unit_price: 3100, status: "packaged", item: @item_17, invoice: @invoice_2)
    @invoice_item_28 = InvoiceItem.create!(quantity: 10, unit_price: 44100, status: "packaged", item: @item_18, invoice: @invoice_2)
    @invoice_item_29 = InvoiceItem.create!(quantity: 20, unit_price: 13600, status: "packaged", item: @item_19, invoice: @invoice_2)
    @invoice_item_30 = InvoiceItem.create!(quantity: 30, unit_price: 13200, status: "packaged", item: @item_20, invoice: @invoice_2)
  end

  describe 'As a merchant, when I visit my merchant items index page' do
    it 'I see all of my items' do
      visit merchant_items_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_9.name)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end

    it 'when I click on an item name, I am taken to that merchants items show page' do
      visit merchant_items_path(@merchant_1)

      within '#enabled-items-list' do
        click_link(@item_1.name)
      end

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end

    it 'each item name has a button to enable or disable that item' do
      visit merchant_items_path(@merchant_1)

      within '#enabled-items-list' do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_9.name)
      end

        within "#enabled-item-#{@item_1.id}" do
          expect(page).to_not have_button('Enable')
          expect(page).to have_button('Disable')
          
          click_button('Disable')
        end

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      
      within '#disabled-items-list' do
        expect(page).to have_content(@item_1.name)
      end

      within '#enabled-items-list' do
        expect(page).to_not have_content(@item_1.name)
      end

        within "#disabled-item-#{@item_1.id}" do
          expect(page).to have_button('Enable')
          expect(page).to_not have_button('Disable')
        end
    end

    it 'I see a link to create a new item' do
      visit merchant_items_path(@merchant_1)

      expect(page).to have_link('Create New Item')

      click_link('Create New Item')

      expect(current_path).to eq(new_merchant_item_path(@merchant_1))

      visit merchant_items_path(@merchant_2)

      expect(page).to have_link('Create New Item')

      click_link('Create New Item')

      expect(current_path).to eq(new_merchant_item_path(@merchant_2))
    end

    it 'I see a list of the top 5 most popular items by revenue' do
      visit merchant_items_path(@merchant_1)

      within "#my-items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_9.name)
        expect(page).to have_content(@item_11.name)
        expect(page).to have_content(@item_12.name)
        expect(page).to have_content(@item_13.name)
        expect(page).to have_content(@item_14.name)
        expect(page).to have_content(@item_15.name)
      end
      
      within '#top-items' do
        expect(page).to have_content('Top Items')

        within '#top-items-list' do
          expect(@item_9.name).to appear_before(@item_11.name)
          expect(@item_11.name).to appear_before(@item_15.name)
          expect(@item_15.name).to appear_before(@item_14.name)
          expect(@item_14.name).to appear_before(@item_12.name)
          expect(page).to_not have_content(@item_1.name)
        end
      end

      visit merchant_items_path(@merchant_2)

      within "#my-items" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_10.name)
        expect(page).to have_content(@item_16.name)
        expect(page).to have_content(@item_17.name)
        expect(page).to have_content(@item_18.name)
        expect(page).to have_content(@item_19.name)
        expect(page).to have_content(@item_20.name)
      end

      within '#top-items' do
        expect(page).to have_content('Top Items')
        
        within '#top-items-list' do
          expect(@item_10.name).to appear_before(@item_18.name)
          expect(@item_18.name).to appear_before(@item_20.name)
          expect(@item_20.name).to appear_before(@item_19.name)
          expect(@item_19.name).to appear_before(@item_16.name)
          expect(page).to_not have_content(@item_17.name)
        end
      end
    end

    it 'I see the top selling date for each of my top 5 items' do
      visit merchant_items_path(@merchant_1)

      within "#top-item-#{@item_9.id}" do
        expect(@item_9.top_selling_date).to eq(@invoice_9.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@item_9.top_selling_date)
      end

      visit merchant_items_path(@merchant_2)
      
      within "#top-item-#{@item_18.id}" do
        expect(@item_18.top_selling_date).to eq(@invoice_2.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@item_18.top_selling_date)
      end
    end
  end
end