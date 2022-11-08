require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Marvel')
    @merchant2 = Merchant.create!(name: 'D.C.')
    @customer1 = Customer.create!(first_name: 'Peter', last_name: 'Parker')
    @customer2 = Customer.create!(first_name: 'Clark', last_name: 'Kent')
    @customer3 = Customer.create!(first_name: 'Louis', last_name: 'Lane')
    @customer4 = Customer.create!(first_name: 'Lex', last_name: 'Luther')
    @customer5 = Customer.create!(first_name: 'Frank', last_name: 'Castle')
    @customer6 = Customer.create!(first_name: 'Matt', last_name: 'Murdock')
    @customer7 = Customer.create!(first_name: 'Bruce', last_name: 'Wayne')
    @invoice1 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: '2009-05-01 01:31:45')
    @invoice2 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: '2009-06-02 01:35:45')
    @invoice3 = Invoice.create!(status: 'completed', customer_id: @customer3.id, created_at: '2009-07-03 01:22:45')
    @invoice4 = Invoice.create!(status: 'cancelled', customer_id: @customer4.id, created_at: '2009-08-04 01:09:45')
    @invoice5 = Invoice.create!(status: 'completed', customer_id: @customer5.id, created_at: '2009-09-05 01:08:45')
    @invoice6 = Invoice.create!(status: 'completed', customer_id: @customer6.id, created_at: '2009-10-06 01:59:45')
    @invoice7 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: '2009-11-07 01:00:45')
    @invoice8 = Invoice.create!(status: 'completed', customer_id: @customer1.id, created_at: '2009-12-08 01:12:45')
    @invoice9 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: '2010-01-09 01:16:45')
    @invoice10 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: '2010-02-10 01:54:45')
    @invoice11 = Invoice.create!(status: 'completed', customer_id: @customer3.id, created_at: '2010-03-11 01:48:45')
    @invoice12 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: '2010-03-11 01:51:45')
    @invoice13 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: '2010-04-12 01:39:45')
    @invoice14 = Invoice.create!(status: 'completed', customer_id: @customer2.id, created_at: '2010-05-13 01:38:45')
    @invoice15 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: '2010-06-14 01:24:45')
    @invoice16 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: '2010-07-15 01:28:45')
    @invoice17 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: '2010-08-16 01:31:45')
    @invoice18 = Invoice.create!(status: 'completed', customer_id: @customer7.id, created_at: '2010-09-17 01:42:45')
    @item1 = Item.create!(name: 'Beanie Babies', description: 'Investments', unit_price: 100, merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'Bat-A-Rangs', description: 'Weapons', unit_price: 500, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: 'Bat Mask', description: 'Identity Protection', unit_price: 800, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: 'Leotard', description: 'Costume', unit_price: 1850, merchant_id: @merchant1.id)
    @item5 = Item.create!(name: 'Cape', description: 'Fully Functional', unit_price: 900, merchant_id: @merchant1.id)
    @item6 = Item.create!(name: 'Black Makeup', description: 'Gallon Sized', unit_price: 50, merchant_id: @merchant1.id)
    @item7 = Item.create!(name: 'Batmobile', description: 'Only one left in stock', unit_price: 1000000, merchant_id: @merchant1.id)
    @item8 = Item.create!(name: 'Night-Vision Goggles', description: 'Required for night activities', unit_price: 15000, merchant_id: @merchant1.id)
    @item9 = Item.create!(name: 'Bat-Cave', description: 'Bats not included', unit_price: 10000000, merchant_id: @merchant2.id)
    InvoiceItem.create!(quantity: 5, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice2.id)
    InvoiceItem.create!(quantity: 6, unit_price: 100, status: 'pending', item_id: @item1.id, invoice_id: @invoice3.id)
    InvoiceItem.create!(quantity: 12, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice4.id)
    InvoiceItem.create!(quantity: 8, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice5.id)
    InvoiceItem.create!(quantity: 20, unit_price: 100, status: 'packaged', item_id: @item1.id, invoice_id: @invoice6.id)
    InvoiceItem.create!(quantity: 50, unit_price: 500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice7.id)
    InvoiceItem.create!(quantity: 15, unit_price: 500, status: 'shipped', item_id: @item2.id, invoice_id: @invoice8.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice9.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice10.id)
    InvoiceItem.create!(quantity: 15, unit_price: 100, status: 'shipped', item_id: @item1.id, invoice_id: @invoice11.id)
    InvoiceItem.create!(quantity: 50, unit_price: 800, status: 'shipped', item_id: @item3.id, invoice_id: @invoice12.id)
    InvoiceItem.create!(quantity: 100, unit_price: 1850, status: 'shipped', item_id: @item4.id, invoice_id: @invoice13.id)
    InvoiceItem.create!(quantity: 20, unit_price: 900, status: 'shipped', item_id: @item5.id, invoice_id: @invoice14.id)
    InvoiceItem.create!(quantity: 100, unit_price: 50, status: 'shipped', item_id: @item6.id, invoice_id: @invoice15.id)
    InvoiceItem.create!(quantity: 1, unit_price: 1000000, status: 'shipped', item_id: @item7.id, invoice_id: @invoice16.id)
    InvoiceItem.create!(quantity: 5, unit_price: 15000, status: 'shipped', item_id: @item8.id, invoice_id: @invoice17.id)
    InvoiceItem.create!(quantity: 1, unit_price: 10000000, status: 'shipped', item_id: @item9.id, invoice_id: @invoice18.id)
    @transaction1 = Transaction.create!(credit_card_number: '4801647818676136', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: '4654405418249632', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice1.id)
    @transaction3 = Transaction.create!(credit_card_number: '4800749911485986', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice2.id)
    @transaction4 = Transaction.create!(credit_card_number: '4923661117104166', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice3.id)
    @transaction5 = Transaction.create!(credit_card_number: '4536896899874279', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction6 = Transaction.create!(credit_card_number: '4536896899874280', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice4.id)
    @transaction7 = Transaction.create!(credit_card_number: '4536896899874281', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice5.id)
    @transaction8 = Transaction.create!(credit_card_number: '4536896899874286', credit_card_expiration_date: nil, result: 'failed', invoice_id: @invoice6.id)
    @transaction9 = Transaction.create!(credit_card_number: '4636896899874290', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice6.id)
    @transaction10 = Transaction.create!(credit_card_number: '4636896899874291', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice7.id)
    @transaction11 = Transaction.create!(credit_card_number: '4636896899874298', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice8.id)
    @transaction12 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice9.id)
    @transaction13 = Transaction.create!(credit_card_number: '4636896899878732', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice10.id)
    @transaction14 = Transaction.create!(credit_card_number: '4636896899845752', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice11.id)
    @transaction15 = Transaction.create!(credit_card_number: '4801647818676137', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice12.id)
    @transaction16 = Transaction.create!(credit_card_number: '4801647818676138', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice13.id)
    @transaction17 = Transaction.create!(credit_card_number: '4801647818676139', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice14.id)
    @transaction18 = Transaction.create!(credit_card_number: '4801647818676146', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice15.id)
    @transaction19 = Transaction.create!(credit_card_number: '4801647818676147', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice16.id)
    @transaction20 = Transaction.create!(credit_card_number: '4801647818676148', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice17.id)
    @transaction21 = Transaction.create!(credit_card_number: '4801647818676149', credit_card_expiration_date: nil, result: 'success', invoice_id: @invoice18.id)
  end

  describe 'As a merchant' do
    describe 'When I visit my merchant items index page' do
      it 'I see a list of names of all of my items and do not see items for any other merchant' do
        visit "/merchants/#{@merchant1.id}/items"

        expect(page).to have_content("#{@merchant1.name} Inventory")

        expect(page).to have_content('Items:')
        expect(page).to_not have_content('Bat-A-Rangs')

        within("#item-#{@item1.id}") do
          expect(page).to have_content(@item1.name)
        end

        within("#item-#{@item3.id}") do
          expect(page).to have_content(@item3.name)
        end
      end

      it 'Next to each item name I see a button to disable or enable that item.' do
        visit "/merchants/#{@merchant1.id}/items"

        within("#item-#{@item1.id}") do
          expect(page).to have_button('Enable')
        end

        within("#item-#{@item3.id}") do
          expect(page).to have_button('Enable')
        end
      end

      it 'Redirects back to the merchant items index and updates status based on which button is clicked' do
        visit "/merchants/#{@merchant1.id}/items"

        within("#item-#{@item1.id}") do
          expect(page).to have_content('Status: disabled')
        end

        within("#item-#{@item3.id}") do
          expect(page).to have_content('Status: disabled')
          click_button('Enable')
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")

        within("#item-#{@item3.id}") do
          expect(page).to have_content('Status: enabled')
          expect(page).to have_button('Disable')
          expect(page).to_not have_content('Status: disabled')
        end

        within("#item-#{@item1.id}") do
          expect(page).to_not have_content('Status: enabled')
        end
      end

      it 'Splits enabled and disabled items' do
        item4 = Item.create!(name: 'Test2', description: 'test', unit_price: 25, status: 1, merchant_id: @merchant1.id)

        visit "/merchants/#{@merchant1.id}/items"

        within('#enabled') do
          expect(page).to have_content('Enabled Items')
          expect(page).to have_link("#{item4.name}")
          expect(page).to_not have_link("#{@item1.name}")
        end

        within('#disabled') do
          expect(page).to have_content('Disabled Items')
          expect(page).to have_link("#{@item1.name}")
          expect(page).to have_link("#{@item3.name}")
          expect(page).to_not have_link("#{item4.name}")
        end
      end

      it 'sees names of top 5 items by total revenue' do
        visit "/merchants/#{@merchant1.id}/items"

        within('#top_by_revenue') do
          expect(page).to have_content(@item7.name)
          expect(page).to have_content(@item4.name)
          expect(page).to have_content(@item8.name)
          expect(page).to have_content(@item3.name)
          expect(page).to have_content(@item5.name)

          expect("#{@item7.name}").to appear_before("#{@item4.name}")
          expect("#{@item4.name}").to appear_before("#{@item8.name}")
          expect("#{@item8.name}").to appear_before("#{@item3.name}")
          expect("#{@item3.name}").to appear_before("#{@item5.name}")
        end
      end

      it 'has links to each merchant item show page and total revenue generated next to each item' do
        visit "/merchants/#{@merchant1.id}/items"
        # save_and_open_page
        within('#top_by_revenue') do
          expect(page).to have_link("#{@item7.name}")
          expect(page).to have_link("#{@item4.name}")
          expect(page).to have_link("#{@item8.name}")
          expect(page).to have_link("#{@item3.name}")
          expect(page).to have_link("#{@item5.name}")

          expect(page).to have_content(@merchant1.top_items_by_revenue[0].item_revenue)
          expect(page).to have_content(@merchant1.top_items_by_revenue[1].item_revenue)
          expect(page).to have_content(@merchant1.top_items_by_revenue[2].item_revenue)
          expect(page).to have_content(@merchant1.top_items_by_revenue[3].item_revenue)
          expect(page).to have_content(@merchant1.top_items_by_revenue[4].item_revenue)
        end
      end

      it 'has the 5 most popular items with date of most sales for each item' do
        visit "/merchants/#{@merchant1.id}/items"
        # save_and_open_page

        within('#top_by_revenue') do
          expect(page).to have_content("Top selling date was: #{@item7.top_item_selling_date}")
          expect(page).to have_content("Top selling date was: #{@item4.top_item_selling_date}")
          expect(page).to have_content("Top selling date was: #{@item8.top_item_selling_date}")
          expect(page).to have_content("Top selling date was: #{@item3.top_item_selling_date}")
          expect(page).to have_content("Top selling date was: #{@item5.top_item_selling_date}")

          expect("Batmobile").to appear_before("Leotard")
          expect("Leotard").to appear_before("Night-Vision Goggles")
          expect("Night-Vision Goggles").to appear_before("Bat Mask")
          expect("Bat Mask").to appear_before("Cape")
        end
      end
    end
  end
end
