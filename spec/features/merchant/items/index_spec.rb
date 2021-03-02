require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit my merchant items index page ('merchant/merchant_id/items')" do
    before :each do
      @merchant_1 = Merchant.create!(name: 'One')
      @merchant_2 = Merchant.create!(name: 'Two')

      @item_1 = @merchant_1.items.create!(name: 'Item 1', description: 'One description', unit_price: 10)
      @item_2 = @merchant_1.items.create!(name: 'Item 2', description: 'Two Description', unit_price: 20)
      @item_3 = @merchant_2.items.create!(name: 'Item 3', description: 'Three Description', unit_price: 30)
      @item_4 = @merchant_1.items.create!(name: 'Item 4', description: 'Four Description', unit_price: 20, status: 1)
      @item_5 = @merchant_1.items.create!(name: 'Item 5', description: 'Five Description', unit_price: 30, status: 1)
      @item_6 = @merchant_1.items.create!(name: 'Item 6', description: 'Six Description', unit_price: 20)


      @customer_1 = Customer.create!(first_name: "Bob", last_name: "Gu")
      @customer_2 = Customer.create!(first_name: "Steve", last_name: "Smith")
      @customer_3 = Customer.create!(first_name: "Jill", last_name: "Biden")
      @customer_4 = Customer.create!(first_name: "Adriana", last_name: "Green")
      @customer_5 = Customer.create!(first_name: "Sally", last_name: "May")
      @customer_6 = Customer.create!(first_name: "Jo", last_name: "Shmoe")

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "completed")
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: "completed")
      @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: "completed")
      @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: "completed")
      @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: "completed")
      @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: "completed")

      @invoice_items_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id)
      @invoice_items_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id)
      @invoice_items_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id)
      @invoice_items_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id)
      @invoice_items_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id)
      @invoice_items_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_6.id)

      @transaction_01 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000000000, cc_expiration_date: '2000-01-01 00:00:00 -0500', result: true)
      @transaction_02 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000001111, cc_expiration_date: '2001-01-01 00:00:00 -0500', result: true)
      @transaction_03 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000002222, cc_expiration_date: '2002-01-01 00:00:00 -0500', result: true)
      @transaction_04 = Transaction.create!(invoice_id: @invoice_1.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_05 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
      @transaction_06 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2004-01-01 00:00:00 -0500', result: true)
      @transaction_07 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000004444, cc_expiration_date: '2005-01-01 00:00:00 -0500', result: true)
      @transaction_08 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_09 = Transaction.create!(invoice_id: @invoice_2.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_10 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_11 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_12 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_13 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_14 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_15 = Transaction.create!(invoice_id: @invoice_5.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_16 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_17 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_18 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_19 = Transaction.create!(invoice_id: @invoice_3.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_20 = Transaction.create!(invoice_id: @invoice_4.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_21 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
      @transaction_22 = Transaction.create!(invoice_id: @invoice_6.id, cc_number: 0000000000003333, cc_expiration_date: '2003-01-01 00:00:00 -0500', result: true)
    end

    describe 'When I click on the name of an item' do
      it "Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)" do
        visit merchant_items_path(@merchant_1)

      # within('#items-enabled') do
        expect(page).to have_link(@item_2.name)
        expect(page).to have_link(@item_4.name)
      # end

      within('#items-enabled') do
        click_link (@item_4.name)

        expect(current_path).to eq(merchant_item_path(@merchant_1.id, @item_4.id))
        end
      end

      it 'my page has sections for enabled and disabled items and each item has a button that changes its status' do
        item = Item.first

        visit merchant_items_path(@merchant_1)

        within('#items-disabled') do
          expect(page).to have_content(item.name)
          click_on(id: "btn-enable-#{item.id}")
          expect(current_path).to eq(merchant_items_path(@merchant_1))
        end

        within('#items-enabled') do
          expect(page).to have_content(item.name)
        end
      end

      it 'has a link to create new item and when i click on create, a new item is created it is shown on the index page' do
        visit merchant_items_path(@merchant_1)

        click_link('New Item')

        expect(current_path).to eq(new_merchant_item_path(@merchant_1))

        fill_in 'item_name', with: 'New Item'
        fill_in 'item_unit_price', with: 120
        fill_in 'item_description', with: 'New item description yay!'

        click_button 'Submit'
        save_and_open_page

        expect(current_path).to eq(merchant_items_path(@merchant_1))
        expect(page).to have_content("Disabled Items")
        expect(page).to have_content('New Item')
      end

      it "shows the top 5 most popular items by total revenue" do
        visit merchant_items_path(@merchant_1.id)

          within("#top_five_items") do
          expect(@item_1.name).to appear_before(@item_2.name)
          expect(@item_2.name).to appear_before(@item_4.name)
          expect(@item_4.name).to appear_before(@item_5.name)
          expect(@item_5.name).to appear_before(@item_6.name)

          expect(page).to have_no_content(@item_3.name)
        end
      end
    end
  end
end
