require 'rails_helper'

RSpec.describe 'Merchant Item Index' do
    describe 'As a merchant' do
        describe 'When I visit my merchant items index page' do
            before :each do
                @merchant1 = Merchant.create!(name: 'Stevie Plunder')
                @merchant2 = Merchant.create!(name: 'Dave Einstein')
                @hammer = @merchant1.items.create!(name: 'hammer', description: 'it is hammer time', unit_price: 2500)
                @candlestick = @merchant1.items.create!(name: 'candlestick', description: 'put a candle on it...or beat someone with it', unit_price: 2000)
                @bat = @merchant2.items.create!(name: 'bat', description: 'Hit a baseball with it', unit_price: 4500)
                @item1 = Item.create!(name: 'screwdriver', description: 'Screw some screws with it', unit_price: '1000', merchant_id: @merchant1.id)
                @item2 = Item.create!(name: '10mm wrench', description: 'torque some 10mm nuts', unit_price: '800', merchant_id: @merchant1.id)
                @item3 = Item.create!(name: '12mm wrench', description: 'torque some 12mm nuts', unit_price: '800', merchant_id: @merchant1.id)
                @item4 = Item.create!(name: '14mm wrench', description: 'torque some 14mm nuts', unit_price: '800', merchant_id: @merchant1.id)
                @item5 = Item.create!(name: '16mm wrench', description: 'torque some 16mm nuts', unit_price: '800', merchant_id: @merchant1.id)
                @customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
                @invoice1 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: "2022-03-25 09:54:09 UTC")
                @invoice2 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: "2022-02-25 09:54:09 UTC")
                @invoice3 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: "2022-04-25 09:54:09 UTC")
                @invoice4 = Invoice.create!(status: "completed", customer_id: @customer1.id, created_at: "2022-04-25 09:54:09 UTC")
                @transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: @invoice1.id)
                @transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: @invoice2.id)
                @transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: @invoice3.id)
                @transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "failed", invoice_id: @invoice4.id)
                @invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: @item1.unit_price, status: "shipped", item_id: @item1.id, invoice_id: @invoice1.id)
                @invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: @item2.unit_price, status: "shipped", item_id: @item2.id, invoice_id: @invoice2.id)
                @invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: @item3.unit_price, status: "shipped", item_id: @item3.id, invoice_id: @invoice3.id)
                @invoice_item4 = InvoiceItem.create!(quantity: 4, unit_price: @item4.unit_price, status: "shipped", item_id: @item4.id, invoice_id: @invoice1.id)
                @invoice_item5 = InvoiceItem.create!(quantity: 10, unit_price: @item5.unit_price, status: "shipped", item_id: @item5.id, invoice_id: @invoice2.id)
                @invoice_item6 = InvoiceItem.create!(quantity: 10, unit_price: @hammer.unit_price, status: "shipped", item_id: @hammer.id, invoice_id: @invoice3.id)
                @invoice_item7 = InvoiceItem.create!(quantity: 100, unit_price: @bat.unit_price, status: "shipped", item_id: @bat.id, invoice_id: @invoice4.id)
            end

            it 'I see a list of the names of all of my items and I do not see items for any other merchant' do
                visit merchant_items_path(@merchant1.id)

                expect(page).to have_content(@hammer.name)
                expect(page).to have_content(@candlestick.name)
                expect(page).to_not have_content(@bat.name)
            end

            it "is able to create a new item" do
              visit merchant_items_path(@merchant1.id)

              click_link 'Create New Item'

              fill_in 'Name', with: 'bricks'
              fill_in 'description', with: 'use to create buildings and create things'
              fill_in 'unit_price', with: '500'

              click_on ("Submit")

              expect(current_path).to eq(merchant_items_path(@merchant1.id))

              expect(page).to have_content('bricks')
            end

            it "is able to enable and disable a item and take you back to the index page and see that the status has changed
            by grouping into one of two sections, enabled and disabled" do
                visit merchant_items_path(@merchant1.id)

                within("#disabled") do
                    expect(page).to have_content(@hammer.name)
                    expect(page).to have_content(@candlestick.name)
                    within("#item-#{@hammer.id}") do
                        click_button 'Enable'
                    end
                    expect(page).to have_current_path("/merchants/#{@merchant1.id}/items")
                    expect(page).to_not have_content(@hammer.name)
                    expect(page).to have_content(@candlestick.name)
                end

                within("#enabled") do
                    expect(page).to have_content(@hammer.name)
                    expect(page).to_not have_content(@candlestick.name)
                    within("#item-#{@hammer.id}") do
                        click_button 'Disable'
                    end
                    expect(page).to have_current_path("/merchants/#{@merchant1.id}/items")
                    expect(page).to_not have_content(@hammer.name)
                end

                within("#disabled") do
                    expect(page).to have_content(@hammer.name)
                    expect(page).to have_content(@candlestick.name)
                end
            end

            it 'shows the names of the top 5 most popular items ranked by total revenue generated' do
                visit merchant_items_path(@merchant1.id)
                within("#top-items") do
                    expect(@hammer.name).to appear_before(@item5.name)
                    expect(@item5.name).to appear_before(@item4.name)
                    expect(@item4.name).to appear_before(@item2.name)
                    expect(@item2.name).to appear_before(@item1.name)
                    expect(page).to_not have_content(@item3.name)
                    expect(page).to_not have_content(@bat.name)
                end
            end

            it 'and I see that each item name links to my merchant item show page for that item' do
                visit merchant_items_path(@merchant1.id)
                within("#top-items") do
                    expect(page).to have_link(@hammer.name)
                    expect(page).to have_link(@item5.name)
                    expect(page).to have_link(@item4.name)
                    expect(page).to have_link(@item2.name)
                    expect(page).to have_link(@item1.name)
                    expect(page).to_not have_link(@item3.name)
                    click_link(@hammer.name)
                    expect(current_path).to eq(merchant_item_path(@merchant1, @hammer))
                end
            end

            it 'and I see the total revenue generated next to each item name' do
                visit merchant_items_path(@merchant1.id)
                within("#top-items") do
                    within("#top-item-#{@hammer.id}") do
                        expect(page).to have_content("$250.00 in sales")
                    end
                    within("#top-item-#{@item1.id}") do
                        expect(page).to have_content("$10.00 in sales")
                    end
                end
            end

            it "next to each of the 5 most popular items I see the date with the most sales for each item.
            and I see a label 'Top Selling date for <item name> was <date>" do
                visit merchant_items_path(@merchant1.id)
                within("#top-items") do
                    within("#top-item-#{@hammer.id}") do
                        expect(page).to have_content("Top selling day for hammer was 2022-04-25")
                    end
                    within("#top-item-#{@item1.id}") do
                        expect(page).to have_content("Top selling day for screwdriver was 2022-03-25")
                    end
                end
            end
        end
    end
end
