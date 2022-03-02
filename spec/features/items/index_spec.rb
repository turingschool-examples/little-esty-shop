require 'rails_helper'

RSpec.describe 'Item Index page' do 
    before(:each) do 
        @merchant_1 = create(:merchant)
        @item_1 = create(:item, merchant_id: @merchant_1.id)
        @item_2 = create(:item, merchant_id: @merchant_1.id)
        @item_5 = create(:item, merchant_id: @merchant_1.id)
        @merchant_2 = create(:merchant)
        @item_3 = create(:item, merchant_id: @merchant_2.id)
        @item_4 = create(:item, merchant_id: @merchant_2.id)
    end
    it 'will show a list of items that a merchant has' do 
        visit "/merchants/#{@merchant_1.id}/merchant_items"
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to_not have_content(@item_3.name)
        expect(page).to_not have_content(@item_4.name)
    end
    it 'will have links on the name that will direct user to show page of item' do 
        visit "/merchants/#{@merchant_1.id}/merchant_items"
        click_on"#{@item_1.name}"
        expect(current_path).to eq("/merchants/#{@merchant_1.id}/merchant_items/#{@item_1.id}")
    end
    it 'will have a section for enabled items' do 
        @item_5.enabled!
        visit "/merchants/#{@merchant_1.id}/merchant_items"
        within ".enabled" do 
            expect(page).to have_content(@item_5.name)
        end
        within ".disabled" do 
            expect(page).to have_content(@item_1.name)
        end
    end
    it 'will have a link to add a new item on the page' do 
        visit "/merchants/#{@merchant_1.id}/merchant_items"
        expect(page).to have_link('Create Item')
    end
    describe 'Merchant Item Disable/Enable' do 
        it 'disabled items can be enabled with button click' do 
            merchant = create(:merchant)
            item_1 = create(:item, merchant_id: merchant.id, status: 0)
            item_2 = create(:item, merchant_id: merchant.id, status: 0)
            item_3 = create(:item, merchant_id: merchant.id)
            visit "/merchants/#{merchant.id}/merchant_items/"
            within(".enabled") do 
                expect(page).to have_content(item_1.name)
                expect(page).to have_content(item_2.name)
                expect(page).to_not have_content(item_3.name)
            end
            within(".disabled") do 
                expect(page).to have_content(item_3.name)
            end
            
            click_button("Enable")
            
            within(".enabled") do 
                expect(page).to have_content(item_1.name)
                expect(page).to have_content(item_2.name)
                expect(page).to have_content(item_3.name)
            end
            within(".disabled") do 
                expect(page).to_not have_content(item_3.name)
            end
        end
        it 'enabled items can be DISABLED with button click' do 
            merchant = create(:merchant)
            item_1 = create(:item, merchant_id: merchant.id, status: 0)
            item_2 = create(:item, merchant_id: merchant.id)
            item_3 = create(:item, merchant_id: merchant.id)
            visit "/merchants/#{merchant.id}/merchant_items/"
            within(".enabled") do 
                expect(page).to have_content(item_1.name)
                expect(page).to_not have_content(item_2.name)
                expect(page).to_not have_content(item_3.name)
            end
            within(".disabled") do 
                expect(page).to have_content(item_2.name)
                expect(page).to have_content(item_3.name)
                expect(page).to_not have_content(item_1.name)
            end
            
            click_button("Disable")
            
            within(".enabled") do 
                expect(page).to_not have_content(item_1.name)
            end
            within(".disabled") do 
                expect(page).to have_content(item_1.name)
                expect(page).to have_content(item_2.name)
                expect(page).to have_content(item_3.name)
            end
        end
    end
    describe '5 most popular items' do 
        before(:each) do 
            @merchant_1 = create(:merchant)
            #all items belong to merchant 1
            @item_1 = create(:item, merchant_id: @merchant_1.id, name: 'Stuffed Bear')
            @item_2 = create(:item, merchant_id: @merchant_1.id, name: 'Doll')
            @item_3 = create(:item, merchant_id: @merchant_1.id, name: 'Roller Skates')
            @item_4 = create(:item, merchant_id: @merchant_1.id, name: 'Yoyo')
            @item_5 = create(:item, merchant_id: @merchant_1.id, name: 'Coloring Book')
            @item_6 = create(:item, merchant_id: @merchant_1.id, name: 'Gift Card')
            # add invoice date for best day 
            @invoice_1 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC')
            @invoice_2 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC')
            @invoice_3 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC')
            @invoice_4 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC')
            @invoice_5 = create(:invoice, created_at: '2012-03-25 14:54:09 UTC')
            @invoice_6 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC')
            @invoice_7 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC')
            # make revenue unique
            @invoice_item_1 = create(:invoice_item, unit_price: 30, quantity: 5, item: @item_1, invoice_id: @invoice_1.id)
            @invoice_item_2 = create(:invoice_item, unit_price: 30, quantity: 4, item: @item_1, invoice_id: @invoice_2.id)
            @invoice_item_3 = create(:invoice_item, unit_price: 50, quantity: 4, item: @item_2, invoice_id: @invoice_3.id)
            @invoice_item_4 = create(:invoice_item, unit_price: 40, quantity: 4, item: @item_3, invoice_id: @invoice_4.id)
            @invoice_item_5 = create(:invoice_item, unit_price: 20, quantity: 4, item: @item_4, invoice_id: @invoice_5.id)
            @invoice_item_6 = create(:invoice_item, unit_price: 90, quantity: 1, item: @item_5, invoice_id: @invoice_6.id)
            @invoice_item_7 = create(:invoice_item, unit_price: 240, quantity: 1, item: @item_6, invoice_id: @invoice_7.id)


            # transactions are successful linked to invoice item
            @transaction_1 = create(:transaction, invoice_id: @invoice_item_1.invoice_id)
            @transaction_2 = create(:transaction, invoice_id: @invoice_item_2.invoice_id)
            @transaction_3 = create(:transaction, invoice_id: @invoice_item_3.invoice_id)
            @transaction_4 = create(:transaction, invoice_id: @invoice_item_4.invoice_id)
            @transaction_5 = create(:transaction, invoice_id: @invoice_item_5.invoice_id)
            @transaction_6 = create(:transaction, invoice_id: @invoice_item_6.invoice_id)
            @transaction_7 = create(:transaction, invoice_id: @invoice_item_7.invoice_id)
            # $270 item 1, $200 item 2, $160 item 3, $80 item 4, $90 item 5, $240 item 6
        end
        it 'will list the names of the 5 most popular items ranked by total revenue' do 
            list = Item.most_popular_items(@merchant_1).map(&:name)
            expect(list).to eq(["Stuffed Bear", "Gift Card", "Doll", "Roller Skates", "Coloring Book"])
        end
        it 'will have the revenues for these items' do 
            list = Item.most_popular_items(@merchant_1).map(&:revenue)
            expect(list).to eq([270, 240, 200, 160, 90])
        end
        it 'will have links to those items' do 
            visit "/merchants/#{@merchant_1.id}/merchant_items"
            within "#item-#{@item_1.id}" do 
                click_link
            end
            expect(current_path).to eq("/merchants/#{@merchant_1.id}/merchant_items/#{@item_1.id}")
        end
        it 'will have the total revenue generated next to each item name' do 
            visit "/merchants/#{@merchant_1.id}/merchant_items"
            within "#item-#{@item_1.id}" do 
                expect(page).to have_content("Total Revenue: $270.00")
            end
        end
        it 'will show the best day' do 
            visit "/merchants/#{@merchant_1.id}/merchant_items"
            within "#item-#{@item_1.id}" do 
                expect(page).to have_content(date_formatter(@item_1.best_day.first.created_at))
            end
        end 
        it 'will show the count of transactions on a given day' do 
            visit "/merchants/#{@merchant_1.id}/merchant_items"
            within "#item-#{@item_1.id}" do 
                expect(page).to have_content(@item_1.best_day.first.count)
            end
        end
    end
end