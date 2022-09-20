require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  describe 'User Story 6 - Merchant Items Index Page' do
    describe 'When I visit my merchant items index page ("merchants/merchant_id/items")' do
      it 'I see a list of the names of all of my items, and dont see items for other merchants' do

        merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
        merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

        item_toothpaste = merchant_stephen.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
        item_rock = merchant_stephen.items.create!(name: "Item Rock", description: "Decently cool rock", unit_price: 4000 )

        item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000 )


        #visit "/merchants/#{merchant_stephen.id}/items"
        visit merchant_items_path(merchant_stephen)

        expect(page).to have_content("Merchant Items Index Page")
        expect(page).to have_content(item_toothpaste.name)
        expect(page).to have_content("Item Toothpaste")
        expect(page).to have_content(item_rock.name)
        expect(page).to_not have_content(item_lamp.name)
      end
    end
  end

  describe 'User Story 9 - Merchant Item Disable/Enable' do
    describe 'As merchant, When I visit my items index page' do
      describe 'Next to each item name I see a button to disable or enable that item.' do
        describe 'When I click this button then I am redirected back to the items index' do
          it 'And I see that the items status has changed' do

            merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
            merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

            item_toothpaste = merchant_stephen.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
            item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000 )

            visit merchant_items_path(merchant_stephen)

            expect(item_toothpaste.enabled).to eq(false)

            within("#item_#{item_toothpaste.id}") do
            click_button("Enable")
            end

            expect(current_path).to eq(merchant_items_path(merchant_stephen))

            within("#item_#{item_toothpaste.id}") do
            expect(page).to have_button("Disable")
            end

          end
        end
      end
    end
  end

    describe 'User Story 10 - Merchant Items Grouped by Status' do
      describe 'When I visit my merchant items index page' do
        describe 'I see two sections, "Enabled Items" and "Disabled Items"' do
          it 'each Item is listed in the appropriate section' do

            merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
            merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

            item_toothpaste = merchant_stephen.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
            item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000)

            visit merchant_items_path(merchant_stephen)

            within("#disabled_items") do
            expect(page).to have_content(item_toothpaste.name)
            expect(page).to_not have_content(item_lamp.name)
            end

            within("#enabled_items") do
            expect(page).to_not have_content(item_toothpaste.name)
            expect(page).to_not have_content(item_lamp.name)
            end

            within("#item_#{item_toothpaste.id}") do
            click_button("Enable")
            end

            within("#enabled_items") do
            expect(page).to have_content(item_toothpaste.name)
            end

          end
        end
      end
    end

  describe 'User Story 11 - Merchant Item Create' do
    describe 'When I visit my items index page I see a link to create a new item' do
      describe 'When I click link, Im taken to a form that allows me to add item information' do
        describe 'When I fill out the form I click Submit Im taken back to items index page' do
          describe 'And I see the item I just created displayed in the list of items' do
            it 'And I see my item was created with a default status of disabled' do

              merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
              merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

              item_toothpaste = merchant_stephen.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
              item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000)

              visit merchant_items_path(merchant_stephen)

              expect(page).to have_link("Create a New Item")

              click_link("Create a New Item")

              expect(current_path).to eq(new_merchant_item_path(merchant_stephen))

              fill_in "Name", with: "Sword"
              fill_in "Description", with: "A big sword"
              fill_in "Unit price", with: "1000"
              click_button("Submit")

              expect(current_path).to eq(merchant_items_path(merchant_stephen))
              expect(page).to have_content("Sword")
              expect(page).to have_link(item_toothpaste.name)

              the_new_item = Item.find_by(name: "Sword")
              expect(the_new_item.enabled).to eq(false)
            end
          end
        end
      end
    end
  end

  describe 'Merchant Items Index: 5 most popular items' do
    describe 'When I visit my items index page' do
      describe 'Then I see the names of the top 5 most popular items ranked by total revenue generated' do
        describe 'And I see that each item name links to my merchant item show page for that item' do
          it 'And I see the total revenue generated next to each item name' do

            customer = Customer.create!(first_name: "Kanye", last_name: "Banjo")

            merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
            merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

            item_ski = merchant_stephen.items.create!(name: "Ski", description: "fast skis", unit_price: 10)
            item_bike = merchant_stephen.items.create!(name: "Bike", description: "danger bike", unit_price: 10)
            item_climbing_shoes = merchant_stephen.items.create!(name: "Climbing Shoes", description: "fun shoes", unit_price: 10)
            item_snowboard = merchant_stephen.items.create!(name: "Snowboard", description: "slow board", unit_price: 10)
            item_rock = merchant_stephen.items.create!(name: "Rock", description: "a good rock", unit_price: 10)

            item_toothpaste = merchant_stephen.items.create!(name: "Toothpaste", description: "The worst toothpaste you can find", unit_price: 10 )
            item_bowling_shoes = merchant_stephen.items.create!(name: "Bowling Shoes", description: "not fun shoes", unit_price: 10)
            item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 10)

            invoice1 = customer.invoices.create!(status: 1)
            invoice2 = customer.invoices.create!(status: 1)
            invoice3 = customer.invoices.create!(status: 1)
            invoice4 = customer.invoices.create!(status: 1)
            invoice5 = customer.invoices.create!(status: 1)
            invoice6 = customer.invoices.create!(status: 1)
            invoice7 = customer.invoices.create!(status: 1)
            invoice8 = customer.invoices.create!(status: 1)

            transaction1 = invoice1.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
            transaction2 = invoice2.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
            transaction3 = invoice3.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
            transaction4 = invoice4.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
            transaction5 = invoice5.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
            transaction6 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
            transaction7 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 1)
            transaction8 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)

            invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_ski.id, quantity: 1000, unit_price: 10)
            invoice_item2 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_bike.id, quantity: 900, unit_price: 10)
            invoice_item3 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item_climbing_shoes.id, quantity: 800, unit_price: 10)
            invoice_item4 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item_snowboard.id, quantity: 700, unit_price: 10)
            invoice_item5 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: item_rock.id, quantity: 600, unit_price: 10)
            invoice_item6 = InvoiceItem.create!(invoice_id: invoice6.id, item_id: item_lamp.id, quantity: 500, unit_price: 10)
            invoice_item6 = InvoiceItem.create!(invoice_id: invoice8.id, item_id: item_lamp.id, quantity: 2000, unit_price: 10)

            visit merchant_items_path(merchant_stephen)

            expect(page).to have_content("Top Items")

            within("#top_items") do
            expect(item_ski.name).to appear_before(item_bike.name)
            expect(item_bike.name).to appear_before(item_climbing_shoes.name)
            expect(item_climbing_shoes.name).to appear_before(item_snowboard.name)
            expect(item_snowboard.name).to appear_before(item_rock.name)
            expect(page).to_not have_content(item_lamp.name)
            end

            within("#top_items_id_#{item_ski.id}") do
            expect(page).to have_content("$100.00 in sales")
            end

            within("#top_items_id_#{item_bike.id}") do
            expect(page).to have_content("$90.00 in sales")
            end

            within("#top_items_id_#{item_ski.id}") do
            click_link("Ski")
            expect(current_path).to eq(merchant_item_path(merchant_stephen, item_ski))
            end

          end
        end
      end
    end
  end

  describe 'Merchant Items Index: Top Items Best Day' do
    describe 'When I visit the items index page' do
      describe 'Then next to each of the 5 most popular items I see the date with the most sales for each item' do
        it 'And I see a label “Top selling date for <item name> was <date with most sales>" ' do

          customer = Customer.create!(first_name: "Kanye", last_name: "Banjo")

          merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
          merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

          item_ski = merchant_stephen.items.create!(name: "Ski", description: "fast skis", unit_price: 10)
          item_bike = merchant_stephen.items.create!(name: "Bike", description: "danger bike", unit_price: 10)
          item_climbing_shoes = merchant_stephen.items.create!(name: "Climbing Shoes", description: "fun shoes", unit_price: 10)
          item_snowboard = merchant_stephen.items.create!(name: "Snowboard", description: "slow board", unit_price: 10)
          item_rock = merchant_stephen.items.create!(name: "Rock", description: "a good rock", unit_price: 10)

          item_toothpaste = merchant_stephen.items.create!(name: "Toothpaste", description: "The worst toothpaste you can find", unit_price: 10 )
          item_bowling_shoes = merchant_stephen.items.create!(name: "Bowling Shoes", description: "not fun shoes", unit_price: 10)
          item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 10)

          invoice1 = customer.invoices.create!(status: 1, created_at: '2012-03-27')
          invoice2 = customer.invoices.create!(status: 1, created_at: '2012-03-20')

          invoice3 = customer.invoices.create!(status: 1, created_at: '2013-04-27')
          invoice4 = customer.invoices.create!(status: 1, created_at: '2013-04-20')

          invoice5 = customer.invoices.create!(status: 1, created_at: '2014-04-27')
          invoice6 = customer.invoices.create!(status: 1, created_at: '2014-04-20')

          transaction1 = invoice1.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
          transaction2 = invoice2.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
          transaction3 = invoice3.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
          transaction4 = invoice4.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
          transaction5 = invoice5.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
          transaction6 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 0)
          transaction7 = invoice6.transactions.create!(credit_card_number: 654241894642, credit_card_expiration_date: 0225, result: 1)

          invoice_item1 = InvoiceItem.create!(invoice_id: invoice1.id, item_id: item_ski.id, quantity: 1000, unit_price: 10)
          invoice_item2 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_ski.id, quantity: 950, unit_price: 10)

          invoice_item3 = InvoiceItem.create!(invoice_id: invoice2.id, item_id: item_bike.id, quantity: 900, unit_price: 10)
          invoice_item4 = InvoiceItem.create!(invoice_id: invoice3.id, item_id: item_bike.id, quantity: 800, unit_price: 10)

          invoice_item5 = InvoiceItem.create!(invoice_id: invoice4.id, item_id: item_snowboard.id, quantity: 700, unit_price: 10)
          invoice_item6 = InvoiceItem.create!(invoice_id: invoice5.id, item_id: item_snowboard.id, quantity: 600, unit_price: 10)

          visit merchant_items_path(merchant_stephen)

          within("#top_items_id_#{item_ski.id}") do
          expect(page).to have_content("Top selling date for #{item_ski.name} was 03/27/12")
          end

          within("#top_items_id_#{item_bike.id}") do
          expect(page).to have_content("Top selling date for #{item_bike.name} was 03/20/12")
          end

        end
      end
    end
  end
end
