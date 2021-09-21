require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
    describe 'Display' do
        before :each do

        end

        it 'can display merchant and attribute' do
            merchant = Merchant.create!({name: "Fucko"})
            expect(page).to have_content("Fucko")            
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

            ## needs help with virtual attributes
            expect(page).to have_content("Items Ready To Ship")
            expect(page).to have_content(@item_1.name)
            expect(page).to have_content(@item_1[:invoice_created_at])
            expect(page).to have_content("Invoice Num #{@invoice_1.id}")
            # expect(page).to have_content(@item_2.name)
            # expect(page).to have_content(@item_2[:invoice_created_at])
            # expect(page).to have_link("Invoice Num #{@invoice_2.id}")
            # expect(page).to have_content(@item_3.name)
            # expect(page).to have_content(@item_3[:invoice_created_at])
            # expect(page).to have_link("Invoice Num #{@invoice_3.id}")
            # expect(page).to have_content(@item_4.name)
            # expect(page).to have_content(@item_4[:invoice_created_at])
            # expect(page).to have_link("Invoice Num #{@invoice_4.id}")
        end

        it 'is ordered by oldest created invoice' do
            expect(@item_1.name).to appear_before(@item_2.name)
        end
    end
end