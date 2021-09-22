require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
    describe 'Display' do
        before :each do
            @merchant = Merchant.create!({name: "Doggy"})
            visit(merchant_dashboard_index_path(@merchant))
        end
        
        it 'can display merchant as the title and has links to its items and invoices' do
            expect(page).to have_content("Doggy") 
            expect(page).to have_link("Items")
            expect(page).to have_link("Invoices")           
        end

        it 'can display link to merchants Items' do
            click_link "Items"
            expect(current_path).to eq(merchant_items_path(@merchant))
        end

        it 'can display link to merchants items' do
            click_link "Invoices"
            expect(current_path).to eq(merchant_invoices_path(@merchant))
        end
    end

    describe 'top 5 customers' do
        before :each do
            @merchant_1 = Merchant.create!(name: "Cool Shirts")
            @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)

            # Customer 1 has 2 successful transactions
            @customer_1 = Customer.create!(first_name: 'Bob', last_name: 'Johnson')
            @invoice_1 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
            @invoice_item_1 = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_2 = @invoice_1.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_1 = @invoice_1.transactions.create!(result: "success")
            @invoice_2 = @customer_1.invoices.create!(status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
            @invoice_item_3 = @invoice_2.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_4 = @invoice_2.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_1 = @invoice_2.transactions.create!(result: "success")

            # Customer 2 has 1 succesful transaction
            @customer_2 = Customer.create!(first_name: 'Josh', last_name: 'Johnson')
            @invoice_3 = @customer_2.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
            @invoice_item_5 = @invoice_3.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_6 = @invoice_3.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_2 = @invoice_3.transactions.create!(result: "success")
            
            # Customer 3 has 1 successful transaction and 1 failure the failure is to test that it counts only successful transactions
            @customer_3 = Customer.create!(first_name: 'Micheal', last_name: 'Johnson')
            @invoice_4 = @customer_3.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
            @invoice_item_7 = @invoice_4.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_8 = @invoice_4.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_3 = @invoice_4.transactions.create!(result: "failed")
            @transaction_4 = @invoice_4.transactions.create!(result: "success")

            # Customer 4 has 3 successful transactions
            @customer_4 = Customer.create!(first_name: 'Magic', last_name: 'Johnson')
            @invoice_5 = @customer_4.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
            @invoice_item_9 = @invoice_5.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_10 = @invoice_5.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_5 = @invoice_5.transactions.create!(result: "success")
            @invoice_6 = @customer_4.invoices.create!(status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
            @invoice_item_11 = @invoice_6.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_12 = @invoice_6.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_6 = @invoice_6.transactions.create!(result: "success")
            @invoice_7 = @customer_4.invoices.create!(status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
            @invoice_item_13 = @invoice_7.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_14 = @invoice_7.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_7 = @invoice_7.transactions.create!(result: "success")

            # Customer 5 has no sucessful transactions
            @customer_5 = Customer.create!(first_name: 'Massive', last_name: 'Johnson')
            @invoice_8 = @customer_5.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
            @invoice_item_15 = @invoice_8.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_16 = @invoice_8.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_8 = @invoice_8.transactions.create!(result: "failed")

            # Customer 6 has 1 sucessful transaction
            @customer_6 = Customer.create!(first_name: 'Major', last_name: 'Johnson')
            @invoice_9 = @customer_6.invoices.create!(status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
            @invoice_item_15 = @invoice_9.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_16 = @invoice_9.invoice_items.create!(item: @item_1, quantity: 2, unit_price: 1400, status: "pending")
            @transaction_9 = @invoice_9.transactions.create!(result: "success")

            # To ensure that it picks from the correct merchant
            @merchant_2 = Merchant.create!(name: "Ugly Shirts")
            @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_2.id)

            visit(merchant_dashboard_index_path(@merchant_1))
        end

        it 'displays the Top 5 customers in order of number of sucessful transactions' do
            expect(@customer_4.full_name).to appear_before(@customer_1.full_name)
            expect(@customer_1.full_name).to appear_before(@customer_2.full_name)
            expect(@customer_2.full_name).to appear_before(@customer_3.full_name)
            expect(@customer_3.full_name).to appear_before(@customer_6.full_name)
        end

        it 'displays the number of transactions per customer' do
            within("#Customer-#{@customer_4.id}") do
                expect(page).to have_content("3 Successful Transactions")
            end
        end 
    end

    describe 'items ready to be shipped' do
        before :each do
            @merchant = Merchant.create!({name: "Fucko"})
            @item_1 = @merchant.items.create!({name: "chicken burger", description: "eat the chicken", unit_price: 45000 })
            @item_2 = @merchant.items.create!({name: "dog burger", description: "eat the dog", unit_price: 45641})
            @item_3 = @merchant.items.create!({name: "bird burger", description: "eat the bird", unit_price: 30000})
            @item_4 = @merchant.items.create!({name: "f burger", description: "eat the f", unit_price: 20000})
            @item_5 = @merchant.items.create!({name: "suck burger", description: "eat the suck", unit_price: 20000})
            @item_6 = @merchant.items.create!({name: "goop", description: "dog", unit_price: 34000})
      
      
            @customer_1 = Customer.create!({first_name: "Dog", last_name: "Man"})
            @invoice_1 = @customer_1.invoices.create!({status: "in progress"})
            @pair_1 = @invoice_1.invoice_items.create!({item_id: @item_1.id, quantity: 2, unit_price: 13435, status: "packaged"})
            @invoice_2 = @customer_1.invoices.create!({status: "in progress"})
            @pair_2 = @invoice_2.invoice_items.create!({item_id: @item_2.id, quantity: 1, unit_price: 13435, status: "packaged"})
            @invoice_3 = @customer_1.invoices.create!({status: "in progress"})
            @pair_3 = @invoice_3.invoice_items.create!({item_id: @item_3.id, quantity: 2, unit_price: 13435, status: "packaged"})
      
            @customer_2 = Customer.create!({first_name: "Fuck", last_name: "Dog"})
      
            @invoice_4 = @customer_2.invoices.create!({status: "in progress"})
            @pair_4 = @invoice_4.invoice_items.create!({item_id: @item_4.id, quantity: 1, unit_price: 13435, status: "packaged"})
      
            @invoice_5 = @customer_2.invoices.create!({status: "in progress"})
            @pair_5 = @invoice_5.invoice_items.create!({item_id: @item_5.id, quantity: 1, unit_price: 13435, status: "pending"})

            visit(merchant_dashboard_index_path(@merchant))  
        end

        it 'has a section with items ready to ship from that merchant' do
            @item_1 = double('item')
            # Virtual Attributes
            allow(@item_1).to receive(:invoice_created_at).and_return(@invoice_1.created_at) # invoice created at
            allow(@item_1).to receive(:invoice_id).and_return(@invoice_1.id)
            # Object Attributes
            allow(@item_1).to receive(:name).and_return('chicken burger')
            allow(@item_1).to receive(:description).and_return('eat the chicken')
            allow(@item_1).to receive(:unit_price).and_return(45000)

            expect(page).to have_content("Items Ready To Ship")
            expect(page).to have_content(@item_1.name)
            expect(page).to have_content(@item_1.invoice_created_at.strftime("%A, %B-%e, %Y"))
            expect(page).to have_link("Invoice # #{@invoice_1.id}")
        end

        it 'is ordered by oldest created invoice' do
            expect(@item_1.name).to appear_before(@item_2.name)
            expect(@item_2.name).to appear_before(@item_3.name)
            expect(@item_3.name).to appear_before(@item_4.name)
        end
    end
end