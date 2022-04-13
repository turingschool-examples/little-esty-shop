require 'rails_helper'

RSpec.describe 'merchant items index page' do
  describe 'as a merchant' do
    describe 'when i visit my merchant items index page' do
      it 'i see a list of the names of all of my items and i do not see items for any other merchant' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        merchant_2 = Merchant.create!(name: "Bill's Less Rare Guitars")
        item_3 = merchant_2.items.create!(name: "2006 Ibanez GX500",
                                          description: "Green Burst Finish, Rosewood Fingerboard",
                                          unit_price: 50000)

        visit "/merchants/#{merchant_1.id}/items"

        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).not_to have_content(item_3.name)
      end

      it 'next to each item name, i see a button to disable or enable that item' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)

        visit "/merchants/#{merchant_1.id}/items"

        within("#item-#{item_1.id}") do
          expect(page).to have_button("Enable")
        end

        within("#item-#{item_2.id}") do
          expect(page).to have_button("Enable")
        end

        within("#item-#{item_3.id}") do
          expect(page).to have_button("Disable")
        end
      end

      it 'when i click the disable/enable button, i am redirected back to the
          items index and i see that that items status has changed' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)

        visit "/merchants/#{merchant_1.id}/items"

        within("#item-#{item_1.id}") do
          click_button("Enable")
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        within("#item-#{item_1.id}") do
          expect(page).to have_button("Disable")
        end

        within("#item-#{item_2.id}") do
          expect(page).to have_button("Enable")
        end

        within("#item-#{item_3.id}") do
          click_button("Disable")
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        within("#item-#{item_3.id}") do
          expect(page).to have_button("Enable")
        end
      end

      it 'i see two sections: one for Enabled Items and one for Disabled Items' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000,
                                        status: 1)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)
        item_4 = merchant_1.items.create!(name: "1982 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 600000)

        visit "/merchants/#{merchant_1.id}/items"

        within("#disabled_items") do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_content(item_2.name)
          within("#item-#{item_2.id}") do
            expect(page).to have_button("Enable")
          end

          expect(page).to have_content(item_4.name)
          within("#item-#{item_4.id}") do
            expect(page).to have_button("Enable")
          end

          expect(page).not_to have_content(item_1.name)
          expect(page).not_to have_content(item_3.name)
          expect(page).not_to have_button("Disable")
        end

        within("#enabled_items") do
          expect(page).to have_content("Enabled Items")

          expect(page).to have_content(item_1.name)
          within("#item-#{item_1.id}") do
            expect(page).to have_button("Disable")
          end

          expect(page).to have_content(item_3.name)
          within("#item-#{item_3.id}") do
            expect(page).to have_button("Disable")
          end

          expect(page).not_to have_content(item_2.name)
          expect(page).not_to have_content(item_4.name)
          expect(page).not_to have_button("Enable")
        end
      end

      it 'i see a link to create a new item, which, when clicked, takes me to
          a form that allows me to add information, and when i click submit, i
          am taken back to the index page and i see the new item listed in the
          disabled section' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000,
                                        status: 1)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000,
                                        status: 1)
        item_4 = merchant_1.items.create!(name: "1982 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 600000)

        visit "/merchants/#{merchant_1.id}/items"

        click_link "Create New Item"

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")

        fill_in "Name", with: "1997 Fender Stratocaster Plus Deluxe"
        fill_in "Description", with: "Sunburst Finish, Maple Fingerboard"
        fill_in "Unit price", with: 180000
        click_button 'Submit'

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        within("#disabled_items") do
          expect(page).to have_content("1997 Fender Stratocaster Plus Deluxe")
        end
      end

      it 'i see the names of the top 5 most popular items by total revenue,
          which are also links to those items show pages, and i see those
          items total revenue generated' do
        merchant_1 = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant_1.items.create!(name: "1959 Gibson Les Paul",
                                        description: "Tobacco Burst Finish, Rosewood Fingerboard",
                                        unit_price: 25000000)
        item_2 = merchant_1.items.create!(name: "1954 Fender Stratocaster",
                                        description: "Seafoam Green Finish, Maple Fingerboard",
                                        unit_price: 10000000)
        item_3 = merchant_1.items.create!(name: "1968 Gibson SG",
                                        description: "Cherry Red Finish, Rosewood Fingerboard",
                                        unit_price: 400000)
        item_4 = merchant_1.items.create!(name: "1984 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 600000)
        item_5 = merchant_1.items.create!(name: "1991 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 900000)
        item_6 = merchant_1.items.create!(name: "1993 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 700000)
        item_7 = merchant_1.items.create!(name: "2004 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 200000)
        item_8 = merchant_1.items.create!(name: "1997 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 100000)
        item_9 = merchant_1.items.create!(name: "1996 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 100000)
        item_10 = merchant_1.items.create!(name: "1975 Gibson Les Paul",
                                        description: "Sunburst Finish, Maple Fingerboard",
                                        unit_price: 400000)
        customer_1 = Customer.create!(first_name: "Guthrie", last_name: "Govan")

        invoice_1 = customer_1.invoices.create!(status: 1)
        invoice_2 = customer_1.invoices.create!(status: 0)
        invoice_item_1 = InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: item_1.unit_price, status: 0)
        invoice_item_2 = InvoiceItem.create!(item: item_9, invoice: invoice_1, quantity: 25, unit_price: item_9.unit_price, status: 0)
        invoice_item_3 = InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 1, unit_price: item_2.unit_price, status: 0)
        invoice_item_4 = InvoiceItem.create!(item: item_4, invoice: invoice_1, quantity: 31, unit_price: item_4.unit_price, status: 0)
        invoice_item_5 = InvoiceItem.create!(item: item_3, invoice: invoice_1, quantity: 35, unit_price: item_3.unit_price, status: 0)
        invoice_item_6 = InvoiceItem.create!(item: item_5, invoice: invoice_1, quantity: 10, unit_price: item_5.unit_price, status: 0)
        invoice_item_7 = InvoiceItem.create!(item: item_6, invoice: invoice_1, quantity: 17, unit_price: item_6.unit_price, status: 0)
        invoice_item_8 = InvoiceItem.create!(item: item_8, invoice: invoice_1, quantity: 10000, unit_price: item_8.unit_price, status: 0)
        invoice_item_9 = InvoiceItem.create!(item: item_7, invoice: invoice_1, quantity: 1, unit_price: item_7.unit_price, status: 0)
        invoice_item_10 = InvoiceItem.create!(item: item_10, invoice: invoice_1, quantity: 4, unit_price: item_10.unit_price, status: 0)
        invoice_item_11 = InvoiceItem.create!(item: item_5, invoice: invoice_2, quantity: 10000, unit_price: item_5.unit_price, status: 0)
        invoice_item_12 = InvoiceItem.create!(item: item_7, invoice: invoice_2, quantity: 10000, unit_price: item_7.unit_price, status: 0)
        transaction_1 = invoice_1.transactions.create!(credit_card_number: 0000111122223333, result: "success")
        transaction_2 = invoice_2.transactions.create!(credit_card_number: 0000111122223333, result: "failed")

        visit "/merchants/#{merchant_1.id}/items"

        within "#most_popular_items" do
          expect(item_8.name).to appear_before(item_1.name)
          expect(item_1.name).to appear_before(item_4.name)
          expect(item_4.name).to appear_before(item_3.name)
          expect(item_3.name).to appear_before(item_6.name)
        end

        within "#popular_item-#{item_8.id}" do
          expect(page).to have_content("Total Revenue: $10000000.00")
        end

        within "#popular_item-#{item_1.id}" do
          expect(page).to have_content("Total Revenue: $250000.00")
        end

        within "#popular_item-#{item_4.id}" do
          expect(page).to have_content("Total Revenue: $186000.00")
        end

        within "#popular_item-#{item_3.id}" do
          expect(page).to have_content("Total Revenue: $140000.00")
        end

        within "#popular_item-#{item_6.id}" do
          expect(page).to have_content("Total Revenue: $119000.00")
        end

        within "#popular_item-#{item_3.id}" do
          click_link "#{item_3.name}"
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_3.id}")
      end
    end
  end
end
