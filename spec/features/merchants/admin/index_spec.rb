require 'rails_helper'

RSpec.describe 'admin merchant index' do
    it 'displays name of each merchant in the system' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)
        merchant_4 = create(:merchant)

        visit '/admin/merchants'
         
        expect(page).to have_content(merchant_1.name)
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_content(merchant_4.name)
        expect(page).to_not have_content(merchant_4.id)
    end
        
    it 'Admin Merchant Enable/Disable' do 
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)         
        merchant_4 = create(:merchant, status: 1)
    
        visit '/admin/merchants/'

        expect(page).to have_content(merchant_1.name)
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_button("Disable", count: 3)
        
        expect(page).to have_content(merchant_4.name)
        expect(merchant_4.status).to eq("disabled")
        expect(page).to have_button("Enable", count: 1)
        
        click_button("Enable")
        expect(current_path).to eq("/admin/merchants/")
        
        
        expect(page).to have_content(merchant_1.name)
        expect(page).to have_content(merchant_2.name)
        expect(page).to have_content(merchant_3.name)
        expect(page).to have_content(merchant_4.name)
        expect(page).to have_button("Disable", count: 4)
        expect(page).to_not have_button("Enable")
    end

    it 'Admin Merchants Grouped by Status' do 
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)         
        merchant_4 = create(:merchant, status: 1)
    
        visit '/admin/merchants/'
        
        within ".enabled" do 
            expect(page).to have_content(merchant_1.name)
            expect(page).to have_content(merchant_2.name)
            expect(page).to have_content(merchant_3.name)
            expect(page).to have_button("Disable", count: 3)
        end
        
        within ".disabled" do 
            expect(page).to have_content(merchant_4.name)
            expect(page).to have_button("Enable", count: 1)
        end
        
        click_button("Enable")
        expect(current_path).to eq("/admin/merchants/")
        
        within ".enabled" do 
            expect(page).to have_content(merchant_1.name)
            expect(page).to have_content(merchant_2.name)
            expect(page).to have_content(merchant_3.name)
            expect(page).to have_content(merchant_4.name)
            expect(page).to have_button("Disable", count: 4)
        end
        
        within ".disabled" do 
            expect(page).to_not have_content(merchant_4.name)
            expect(page).to_not have_button("Enable", count: 1)
        end
    end
    
    it 'Admin Merchant Create' do 
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        merchant_3 = create(:merchant)         
        merchant_4 = create(:merchant, status: 1)
        
        visit '/admin/merchants/'
        
        expect(page).to have_link("New Merchant")
        expect(page).to_not have_content("Arch City Apparel")
        click_link("New Merchant")
        expect(current_path).to eq("/admin/merchants/new")
        
        fill_in 'name', with: "Arch City Apparel"
        click_button("Submit")
        expect(current_path).to eq("/admin/merchants/")
        
        within ".disabled" do 
            expect(page).to have_content("Arch City Apparel")
            expect(page).to have_content(merchant_4.name)
            expect(page).to have_button("Enable", count: 2)
            expect(page).to_not have_content(merchant_1.name)
        end
    end

    describe 'Top Merchants By Revenue and Best Day for top Merchants' do 
        before(:each) do 
            # Revenue Generated: 530
            @merchant_1 = create(:merchant)
            @item_1 = create(:item, merchant_id: @merchant_1.id, name: 'Stuffed Bear')
            @item_2 = create(:item, merchant_id: @merchant_1.id, name: 'Doll')
        
            # # Revenue Generated: 240
            @merchant_2 = create(:merchant)
            @item_3 = create(:item, merchant_id: @merchant_2.id, name: 'Roller Skates')
            @item_4 = create(:item, merchant_id: @merchant_2.id, name: 'Yoyo')
            
            # # Revenue Generated: 330
            @merchant_3 = create(:merchant)
            @item_5 = create(:item, merchant_id: @merchant_3.id, name: 'Coloring Book')
            @item_6 = create(:item, merchant_id: @merchant_3.id, name: 'RC Car')
            
            # # Revenue Generated: 200
            @merchant_4 = create(:merchant)
            @item_7 = create(:item, merchant_id: @merchant_4.id, name: 'Gift Card')
            
            # # Revenue Generated: 45
            @merchant_5 = create(:merchant)
            @item_8 = create(:item, merchant_id: @merchant_5.id, name: 'Costume')
            
            # # Revenue Generated: 10
            @merchant_6 = create(:merchant)
            @item_9 = create(:item, merchant_id: @merchant_6.id, name: 'Puzzle')
            
            # Revenue Generated: 210
            @invoice_1 = create(:invoice, created_at: '2012-03-21 14:54:09 UTC', status: 1)
            # Revenue Generated: 120
            @invoice_2 = create(:invoice, created_at: '2012-03-22 14:54:09 UTC', status: 1)
            # # Revenue Generated: 200
            @invoice_3 = create(:invoice, created_at: '2012-03-22 14:54:09 UTC', status: 1)
            # Revenue Generated: 160
            @invoice_4 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC', status: 1)
            # # Revenue Generated: 80
            @invoice_5 = create(:invoice, created_at: '2012-03-25 14:54:09 UTC', status: 1)
            # # Revenue Generated: 90
            @invoice_6 = create(:invoice, created_at: '2012-03-24 14:54:09 UTC', status: 1)
            # # Revenue Generated: 240
            @invoice_7 = create(:invoice, created_at: '2012-03-23 14:54:09 UTC', status: 1)
            # # Revenue Generated: 200
            @invoice_8 = create(:invoice, created_at: '2012-03-27 14:54:09 UTC', status: 1)
            # # Revenue Generated: 55
            @invoice_9 = create(:invoice, created_at: '2012-03-26 14:54:09 UTC', status: 1)
            @invoice_10 = create(:invoice, created_at: '2012-03-27 14:54:09 UTC', status: 1)
            
            # Revenue Generated: 210
            @invoice_item_1 = create(:invoice_item, unit_price: 30, quantity: 7, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 2)
            # Revenue Generated: 120
            @invoice_item_2 = create(:invoice_item, unit_price: 30, quantity: 4, item_id: @item_1.id, invoice_id: @invoice_2.id, status: 2)
            # # Revenue Generated: 200
            @invoice_item_3 = create(:invoice_item, unit_price: 50, quantity: 4, item_id: @item_2.id, invoice_id: @invoice_3.id, status: 2)
            # Revenue Generated: 160
            @invoice_item_4 = create(:invoice_item, unit_price: 40, quantity: 4, item_id: @item_3.id, invoice_id: @invoice_4.id, status: 2)
            # # Revenue Generated: 80
            @invoice_item_5 = create(:invoice_item, unit_price: 20, quantity: 4, item_id: @item_4.id, invoice_id: @invoice_5.id, status: 2)
            # # Revenue Generated: 90
            @invoice_item_6 = create(:invoice_item, unit_price: 90, quantity: 1, item_id: @item_5.id, invoice_id: @invoice_6.id, status: 2)
            # # Revenue Generated: 240
            @invoice_item_7 = create(:invoice_item, unit_price: 240, quantity: 1, item_id: @item_6.id, invoice_id: @invoice_7.id, status: 2)
            # # Revenue Generated: 200
            @invoice_item_8 = create(:invoice_item, unit_price: 200, quantity: 1, item_id: @item_7.id, invoice_id: @invoice_8.id, status: 2)
            # # Revenue Generated: 45
            @invoice_item_9 = create(:invoice_item, unit_price: 45, quantity: 1, item_id: @item_8.id, invoice_id: @invoice_9.id, status: 2)
            # # Revenue Generated: 10
            @invoice_item_10 = create(:invoice_item, unit_price: 10, quantity: 1, item_id: @item_9.id, invoice_id: @invoice_10.id, status: 2)
            # @invoice_item_10 = create(:invoice_item, unit_price: 10, quantity: 1, item_id: @item_9.id, invoice_id: @invoice_10.id, status: 2)
            
            @transaction_1 = create(:transaction, invoice_id: @invoice_item_1.invoice_id, result: 0)
            @transaction_2 = create(:transaction, invoice_id: @invoice_item_2.invoice_id, result: 0)
            @transaction_3 = create(:transaction, invoice_id: @invoice_item_3.invoice_id, result: 0)
            @transaction_4 = create(:transaction, invoice_id: @invoice_item_4.invoice_id, result: 0)
            @transaction_5 = create(:transaction, invoice_id: @invoice_item_5.invoice_id, result: 0)
            @transaction_6 = create(:transaction, invoice_id: @invoice_item_6.invoice_id, result: 0)
            @transaction_7 = create(:transaction, invoice_id: @invoice_item_7.invoice_id, result: 0)
            @transaction_8 = create(:transaction, invoice_id: @invoice_item_8.invoice_id, result: 0)
            @transaction_9 = create(:transaction, invoice_id: @invoice_item_9.invoice_id, result: 0)
            @transaction_10 = create(:transaction, invoice_id: @invoice_item_10.invoice_id, result: 0)
        end
        it 'lists top 5 mechants ordered by total revenue' do 
            visit '/admin/merchants/'
            
            expect(page).to have_content("Top Merchants")
            
            within ".top_merchants" do 
                expect(page).to have_content(@merchant_1.name)
                expect(page).to have_content(@merchant_3.name)
                expect(@merchant_1.name).to appear_before(@merchant_3.name)
                expect(page).to have_content(@merchant_2.name)
                expect(@merchant_3.name).to appear_before(@merchant_2.name)
                expect(page).to have_content(@merchant_4.name)
                expect(@merchant_2.name).to appear_before(@merchant_4.name)
                expect(page).to have_content(@merchant_5.name)
                expect(@merchant_4.name).to appear_before(@merchant_5.name)
                expect(page).to_not have_content(@merchant_6.name)
            end
        end
        it 'each merchant is a link to the admin merchant show page for that merchant' do 
            visit '/admin/merchants/'
            
            within ".top_merchants" do 
                expect(page).to have_link(@merchant_1.name)
                expect(page).to have_link(@merchant_3.name)
                expect(page).to have_link(@merchant_2.name)
                expect(page).to have_link(@merchant_4.name)
                expect(page).to have_link(@merchant_5.name)
                expect(page).to_not have_link(@merchant_6.name)
            end
            click_link(@merchant_1.name)
            expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
        end
        it 'displays total revenue for each next to merchant name' do 
            visit '/admin/merchants/'
            
            within ".top_merchants" do 
                expect(page).to have_content("#{@merchant_1.name} - $530.00 in sales")
                expect(page).to have_content("#{@merchant_3.name} - $330.00 in sales")
                expect(page).to have_content("#{@merchant_2.name} - $240.00 in sales")
                expect(page).to have_content("#{@merchant_4.name} - $200.00 in sales")
                expect(page).to have_content("#{@merchant_5.name} - $45.00 in sales")
            end
        end
        it 'shows best date next to each merchant when they had the most single-day revenue' do 
            visit '/admin/merchants/'
            
            within ".top_merchants" do 
                expect(page).to have_content("Top selling date for #{@merchant_1.name} was #{date_formatter(@merchant_1.best_day.first.created_at)}")
                expect(page).to have_content("Top selling date for #{@merchant_3.name} was #{date_formatter(@merchant_3.best_day.first.created_at)}")
                expect(page).to have_content("Top selling date for #{@merchant_2.name} was #{date_formatter(@merchant_2.best_day.first.created_at)}")
                expect(page).to have_content("Top selling date for #{@merchant_4.name} was #{date_formatter(@merchant_4.best_day.first.created_at)}")
                expect(page).to have_content("Top selling date for #{@merchant_5.name} was #{date_formatter(@merchant_5.best_day.first.created_at)}")
            end
        end
    end
    
    describe 'Merchants can be sorted by name or created_date' do 
        before(:each) do 
            @merchant_1 = create(:merchant, name: "Dell", created_at: '2012-03-22 14:54:09 UTC')
            @merchant_2 = create(:merchant, name: "Keychron", created_at: '2012-03-20 14:54:09 UTC')
            @merchant_3 = create(:merchant, name: "Arch City Apparel", created_at: '2012-03-24 14:54:09 UTC')         
            @merchant_4 = create(:merchant, name: "Uplift", status: 1, created_at: '2012-03-24 14:54:09 UTC')
            @merchant_5 = create(:merchant, name: "Roomba", status: 1, created_at: '2012-03-23 14:54:09 UTC')
        end
        it 'has links to sort alphabetically and by created_at date' do
            visit '/admin/merchants/'
            expect(page).to have_link("Sort Alphabetically")
            expect(page).to have_link("Sort by Date Created")
        end
        it 'sorts alphabetically when link is clicked' do 
            visit '/admin/merchants/'
            within ".enabled" do 
               expect(@merchant_1.name).to appear_before(@merchant_2.name) 
               expect(@merchant_2.name).to appear_before(@merchant_3.name)
               expect(page).to_not have_content(@merchant_4.name)
               expect(page).to_not have_content(@merchant_5.name)
            end
            within ".disabled" do 
                expect(@merchant_4.name).to appear_before(@merchant_5.name)
                expect(page).to_not have_content(@merchant_1.name)
                expect(page).to_not have_content(@merchant_3.name)
            end
            
            click_link("Sort Alphabetically")
            
            within ".enabled" do 
                expect(@merchant_3.name).to appear_before(@merchant_1.name) 
                expect(@merchant_1.name).to appear_before(@merchant_2.name)
                expect(page).to_not have_content(@merchant_4.name)
            end
            within ".disabled" do 
                expect(@merchant_5.name).to appear_before(@merchant_4.name)
                expect(page).to_not have_content(@merchant_1.name)
                expect(page).to_not have_content(@merchant_3.name)
            end
        end
        it 'sorts by created_at date when link is clicked' do 
            visit '/admin/merchants/'
            within ".enabled" do 
               expect(@merchant_1.name).to appear_before(@merchant_2.name) 
               expect(@merchant_2.name).to appear_before(@merchant_3.name)
               expect(page).to_not have_content(@merchant_4.name)
               expect(page).to_not have_content(@merchant_5.name)
            end
            within ".disabled" do 
                expect(@merchant_4.name).to appear_before(@merchant_5.name)
                expect(page).to_not have_content(@merchant_1.name)
                expect(page).to_not have_content(@merchant_3.name)
            end
            
            click_link("Sort by Date Created")
            
            within ".enabled" do 
                expect(@merchant_2.name).to appear_before(@merchant_1.name) 
                expect(@merchant_1.name).to appear_before(@merchant_3.name)
                expect(page).to_not have_content(@merchant_4.name)
            end
            within ".disabled" do 
                expect(@merchant_5.name).to appear_before(@merchant_4.name)
                expect(page).to_not have_content(@merchant_1.name)
                expect(page).to_not have_content(@merchant_3.name)
            end
        end
    end
end