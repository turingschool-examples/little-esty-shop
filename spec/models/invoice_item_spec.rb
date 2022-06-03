require 'rails_helper'

RSpec.describe InvoiceItem do
    describe "relationships" do
        it { should belong_to :item } 
        it { should belong_to :invoice } 
        it { should have_many(:transactions).through(:invoice) } 
    end

    describe "class methods" do
        before :each do
            @merch1 = Merchant.create!(name: 'Floopy Fopperations')
            @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
            @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
            @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
            @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
            @item4 = @merch1.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
            @item5 = @merch1.items.create!(name: 'Floopy Green', description: 'the best', unit_price: 450)
            @item6 = @merch1.items.create!(name: 'Floopy Blue', description: 'the better', unit_price: 950)
            @item7 = @merch1.items.create!(name: 'Floopy Red', description: 'the OG', unit_price: 550)
            @item8 = @merch1.items.create!(name: 'Floopy Black', description: 'the OG', unit_price: 550)
            @invoice1 = @customer1.invoices.create!(status: 2)
            @invoice1.transactions.create!(result: 0)
            @invoice2 = @customer1.invoices.create!(status: 2)
            @invoice2.transactions.create!(result: 0)
            InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 10000, status: 0)
            InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 10000, status: 1)
            InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 10000, status: 1)
            InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 4, unit_price: 10000, status: 2)
            InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 10000, status: 0)
            InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 6, unit_price: 10000, status: 2)
            InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 500, status: 2, created_at: Time.parse('2012-03-27 14:54:09 UTC'))
            InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 500, status: 2, created_at: Time.parse('2012-03-30 14:54:09 UTC'))
            InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 10000, status: 2)
        end

        describe "#item_revenue" do
            it 'calculates invoice items revenue' do
                expect(@item8.invoice_items.item_revenue).to eq(100000)
            end
        end
    end
    
end