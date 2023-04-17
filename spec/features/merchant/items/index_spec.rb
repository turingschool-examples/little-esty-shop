require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1, is_enabled: true)
    @item_2 = create(:item, merchant: @merchant_1, is_enabled: true)
    @item_3 = create(:item, merchant: @merchant_1, is_enabled: true)
    @item_4 = create(:item, merchant: @merchant_1)
    @item_5 = create(:item, merchant: @merchant_1)
    @item_6 = create(:item, merchant: @merchant_1)
    @item_7 = create(:item, merchant: @merchant_1)

    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: true)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 70000)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 60000)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 50000)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 40000)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 30000)
    @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 20000)
    @invoice_item_7 = create(:invoice_item, item_id: @item_7.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 10000)

    visit merchant_items_path(@merchant_1.id)
  end

  describe 'Merchant Items Index Page (User Story 6)' do
    it 'has a header' do
      expect(page).to have_content("#{@merchant_1.name} Items")
    end

    it 'it lists all of the merchant item names as links' do
      visit merchant_items_path(@merchant_1)

      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name)
      end
    end

    it 'does not display items from any other merchant' do
      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant: merchant_2)

      expect(page).to_not have_link(item_2.name)
    end
  end

  describe 'Merchant Item Disable/Enable (User Story 9)' do
    it 'has a button next to each item for enabling or disabling that item' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Disable Item')

        click_button 'Disable Item'

        expect(page).to have_button('Enable Item')
      end
      expect(page).to have_content("#{@merchant_1.name} Items")
    end

    it 'enabling or disabling a button changes its enabled status in the database' do
      expect(@item_1.is_enabled).to eq(true)
      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Disable Item')

        click_button 'Disable Item'
      end
      expect(@item_1.reload.is_enabled).to eq(false)
    end

    it 'displays a flash message that the item has been successfully enabled or disabled ' do
      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Disable Item')

        click_button 'Disable Item'
      end
      expect(page).to have_content("Item successfully disabled!")

      within "#item-#{@item_1.id}" do
        expect(page).to have_button('Enable Item')

        click_button 'Enable Item'
      end
      expect(page).to have_content("Item successfully enabled!")
    end
  end

  describe 'Merchant Items Grouped by Status (User Story 10)' do
    it 'displays a section for "Enabled Items" and "Disabled Items"' do
      expect(page).to have_content("Enabled Items")
      expect(page).to have_content("Disabled Items")
    end

    it 'displays only the enabled items in the "Enabled Items" section' do
      within "#enabled-items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
        expect(page).to_not have_content(@item_4.name)
        expect(page).to_not have_content(@item_5.name)
      end
    end

    it 'displays only the disabled items in the "Disabled Items" section' do
      within "#disabled-items" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)
        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
      end
    end

    describe 'Merchant Items Index: 5 most popular items (User Story 12)' do
      it 'has a header for the top 5 items' do
        within("#top-five-items") do
          expect(page).to have_content("Top 5 Most Popular Items By Revenue")
          expect(page).to have_content("Item Name")
          expect(page).to have_content("Total Revenue")
        end
      end

      it 'displays the 5 most popular items by revenue' do
        within("#top-five-items-1") do
          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(format_currency(@item_1.total_revenue))
        end
        within("#top-five-items-2") do
          expect(page).to have_content(@item_2.name)
          expect(page).to have_content(format_currency(@item_2.total_revenue))
        end
        within("#top-five-items-3") do
          expect(page).to have_content(@item_3.name)
          expect(page).to have_content(format_currency(@item_3.total_revenue))
        end
        within("#top-five-items-4") do
          expect(page).to have_content(@item_4.name)
          expect(page).to have_content(format_currency(@item_4.total_revenue))
        end
        within("#top-five-items-5") do
          expect(page).to have_content(@item_5.name)
          expect(page).to have_content(format_currency(@item_5.total_revenue))
        end
        within("#top-five-items") do
          expect(page).to_not have_content(@item_6.name)
          expect(page).to_not have_content(@item_7.name)
        end
      end
    end

    describe 'Merchant Items Index: Top Item\'s Best Day (User Story 13)' do
      it 'has a header for the top selling date for each of the top 5 items' do
        within("#top-five-items") do
          expect(page).to have_content("Top Selling Date")
        end
      end

      it 'displays the top selling date for each of the top 5 items' do
        within("#top-five-items-1") do
          expect(page).to have_content(format_date(@item_1.top_selling_date))
        end
      end
    end
  end
end
