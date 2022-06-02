require 'rails_helper'

RSpec.describe Merchant do
    describe "relationships" do
        it { should have_many :items }
        it { should have_many(:invoice_items).through(:items) }
        it { should have_many(:invoices).through(:invoice_items) }
    end

    describe "instance methods" do
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
            InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 500, status: 2)
            InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 10000, status: 2)
        end

        it "lists the items ready for shipment" do
            expect(@merch1.ready_items).to eq([@item2, @item3])
        end

        it "list the top 5 items by revenue per a specific merchant" do
            expect(@merch1.top_five_items_by_revenue).to eq([@item8, @item6, @item5, @item4, @item3])
        end
        
    end
end
