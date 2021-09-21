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

    describe 'top 5 customers' do
        before :each do
            @customer_1 = Customer.create(first_name: 'Bob', last_name: 'Johnson')
            @merchant_1 = Merchant.create!(name: "Cool Shirts")
            @merchant_2 = Merchant.create!(name: "Ugly Shirts")
            @merchant_3 = Merchant.create!(name: "Rad Shirts")
            @merchant_4 = Merchant.create!(name: "Bad Shirts")
            @merchant_5 = Merchant.create!(name: "Khoi's Shirts")
            @merchant_6 = Merchant.create!(name: "Kelsey's Shirts")
            @item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: @merchant_1.id)
            @item_2 = Item.create!(name: "Old shirt", description: "less ugly shirt", unit_price: 1000, merchant_id: @merchant_2.id)
            @item_3 = Item.create!(name: "cool shirt", description: "super cool shirt", unit_price: 1700, merchant_id: @merchant_3.id)
            @item_4 = Item.create!(name: "shirt with kitten", description: "super cool shirt", unit_price: 700, merchant_id: @merchant_4.id)
            @item_5 = Item.create!(name: "black shirt", description: "super cool shirt", unit_price: 1600, merchant_id: @merchant_5.id)
            @item_6 = Item.create!(name: "shirt with flowers", description: "super cool shirt", unit_price: 1300, merchant_id: @merchant_6.id)
            @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-25 09:54:09 UTC")
            @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
            @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2010-03-12 09:50:09 UTC")
            @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2017-03-12 06:50:09 UTC")
            @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2009-03-12 09:50:09 UTC")
            @invoice_6 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2012-03-12 09:50:09 UTC")
            @invoice_7 = Invoice.create(customer_id: @customer_1.id, status: 'completed', created_at: "2011-03-11 09:50:09 UTC")
            @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 1, unit_price: 1400, status: "pending")
            @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 1, unit_price: 1000, status: "packaged")
            @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_3, quantity: 1, unit_price: 1700, status: "shipped")
            @invoice_item_4 = InvoiceItem.create!(item: @item_4, invoice: @invoice_4, quantity: 1, unit_price: 700, status: "shipped")
            @invoice_item_5 = InvoiceItem.create!(item: @item_5, invoice: @invoice_5, quantity: 1, unit_price: 1600, status: "shipped")
            @invoice_item_6 = InvoiceItem.create!(item: @item_6, invoice: @invoice_6, quantity: 1, unit_price: 1300, status: "shipped")
            @invoice_item_7 = InvoiceItem.create!(item: @item_1, invoice: @invoice_7, quantity: 2, unit_price: 1400, status: "shipped")
            Transaction.create!(invoice_id: @invoice_1.id, result: "success")
            Transaction.create!(invoice_id: @invoice_2.id, result: "success")
            Transaction.create!(invoice_id: @invoice_3.id, result: "success")
            Transaction.create!(invoice_id: @invoice_4.id, result: "success")
            Transaction.create!(invoice_id: @invoice_5.id, result: "success")
            Transaction.create!(invoice_id: @invoice_6.id, result: "success")
        end

        it 'can re' do
            
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