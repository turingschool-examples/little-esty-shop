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
            @invoice1 = @customer1.invoices.create!(status: 2, updated_at: Time.parse("2012-03-30 14:54:09 UTC"))
            @invoice1.transactions.create!(result: 0)
            @invoice2 = @customer1.invoices.create!(status: 2, updated_at: Time.parse("2012-04-30 14:54:09 UTC"))
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

        it 'gives me the top five customers of a merchant' do
          @merch1 = Merchant.create!(name: 'Floopy Fopperations')
          @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
          @item2 = @merch1.items.create!(name: 'A-Team Original', description: 'the better', unit_price: 950)

          @cust1 = Customer.create!(first_name: "Mark", last_name: "Ruffalo")
          @cust2 = Customer.create!(first_name: "Jim", last_name: "Raddle")
          @cust3 = Customer.create!(first_name: "Bryan", last_name: "Cranston")
          @cust4 = Customer.create!(first_name: "Walter", last_name: "White")
          @cust5 = Customer.create!(first_name: "Hank", last_name: "Williams")
          @cust6 = Customer.create!(first_name: "Sammy", last_name: "Sosa")
          @cust7 = Customer.create!(first_name: "Barry", last_name: "Bonds")

          @inv1 = @cust1.invoices.create!(status: "in progress")
          @inv2 = @cust2.invoices.create!(status: "completed")
          @inv3 = @cust3.invoices.create!(status: "completed")
          @inv4 = @cust4.invoices.create!(status: "completed")
          @inv5 = @cust5.invoices.create!(status: "completed")
          @inv6 = @cust6.invoices.create!(status: "completed")
          @inv7 = @cust7.invoices.create!(status: "completed")

          InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv1.id}", quantity: 100, unit_price: 1000, status: 1)
          InvoiceItem.create!(item_id: "#{@item2.id}", invoice_id: "#{@inv2.id}", quantity: 200, unit_price: 2000, status: 1)
          InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv3.id}", quantity: 200, unit_price: 2000, status: 1)
          InvoiceItem.create!(item_id: "#{@item2.id}", invoice_id: "#{@inv4.id}", quantity: 200, unit_price: 2000, status: 1)
          InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv5.id}", quantity: 200, unit_price: 2000, status: 1)
          InvoiceItem.create!(item_id: "#{@item2.id}", invoice_id: "#{@inv6.id}", quantity: 200, unit_price: 2000, status: 1)
          InvoiceItem.create!(item_id: "#{@item1.id}", invoice_id: "#{@inv7.id}", quantity: 200, unit_price: 2000, status: 1)

          @inv1.transactions.create!(result: 0)
          @inv1.transactions.create!(result: 0)
          @inv1.transactions.create!(result: 0)

          @inv2.transactions.create!(result: 0)
          @inv2.transactions.create!(result: 0)
          @inv2.transactions.create!(result: 0)

          @inv3.transactions.create!(result: 0)
          @inv3.transactions.create!(result: 0)
          @inv3.transactions.create!(result: 0)
          @inv3.transactions.create!(result: 0)

          @inv4.transactions.create!(result: 0)
          @inv4.transactions.create!(result: 0)
          @inv4.transactions.create!(result: 0)
          @inv4.transactions.create!(result: 1)
          @inv4.transactions.create!(result: 1)
          @inv4.transactions.create!(result: 1)
          @inv4.transactions.create!(result: 1)

          @inv5.transactions.create!(result: 0)
          @inv5.transactions.create!(result: 0)
          @inv5.transactions.create!(result: 0)
          @inv5.transactions.create!(result: 0)
          @inv5.transactions.create!(result: 0)

          @inv6.transactions.create!(result: 1)
          @inv6.transactions.create!(result: 1)
          @inv6.transactions.create!(result: 1)
          @inv6.transactions.create!(result: 1)

          @inv7.transactions.create!(result: 0)

          expect(@merch1.top_five_customers).to eq([@cust5, @cust3, @cust1, @cust2, @cust4])
        end


        it 'returns the revenue of all items on the invoice' do
          expect(@invoice1.total_revenue(@merch1.id)).to eq(90500)
        end

        it "list the top 5 items by revenue per a specific merchant" do
          expect(@merch1.top_five_items_by_revenue).to eq([@item8, @item6, @item5, @item4, @item3])
        end

        it "returns the date for the highest revenue" do
          expect(@merch1.merchant_best_day).to eq("#{@invoice2.updated_at}")
        end
    end

    describe "class methods" do
        before :each do
          @merch1 = Merchant.create!(name: 'Floopy Fopperations')
          @merch2 = Merchant.create!(name: 'A-Team')
          @merch3 = Merchant.create!(name: 'Blue Clues')
          @merch4 = Merchant.create!(name: 'Apple Bottom Jeans')
          @merch5 = Merchant.create!(name: 'Rawnald')
          @merch6 = Merchant.create!(name: 'Zombies R Us')
          @merch7 = Merchant.create!(name: 'We are Coffee')
          @merch8 = Merchant.create!(name: 'Hannah French Montanna')
          @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
          @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
          @item2 = @merch2.items.create!(name: 'A-Team Original', description: 'the better', unit_price: 950)
          @item3 = @merch3.items.create!(name: 'Blue Retro', description: 'the OG', unit_price: 550)
          @item4 = @merch4.items.create!(name: 'Apple', description: 'the OG', unit_price: 550)
          @item5 = @merch5.items.create!(name: 'The Rawnald', description: 'the best', unit_price: 450)
          @item6 = @merch6.items.create!(name: 'The Zombie', description: 'the better', unit_price: 950)
          @item7 = @merch7.items.create!(name: 'The Coffee', description: 'the OG', unit_price: 550)
          @item8 = @merch8.items.create!(name: 'The Hannah', description: 'the OG', unit_price: 550)
          @item9 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 1450)
          @invoice1 = @customer1.invoices.create!(status: 2, updated_at: Time.parse("2012-03-30 14:54:09 UTC"))
          @invoice1.transactions.create!(result: 0)
          @invoice2 = @customer1.invoices.create!(status: 2)
          @invoice2.transactions.create!(result: 0)
          @invoice3 = @customer1.invoices.create!(status: 2)
          @invoice3.transactions.create!(result: 1)
          InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 10000, status: 0)
          InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 10000, status: 1)
          InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 10000, status: 1)
          InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 4, unit_price: 10000, status: 2)
          InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 10000, status: 0)
          InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 6, unit_price: 10000, status: 2)
          InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 500, status: 2)
          InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice3.id, quantity: 1000, unit_price: 10000, status: 2)
          InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 20000, status: 2)
        end

        it "gives me the top 5 merchants by revenue" do
            expect(Merchant.top_five_merchants_by_revenue).to eq([@merch1, @merch6, @merch5, @merch4, @merch3])
        end

        describe "#enable / disable merchants" do
            it "returns all merchants based on status, enabled or disabled" do
                expect(Merchant.enabled_merchants).to eq([])
                # require "pry"; binding.pry
                expect(Merchant.disabled_merchants).to match_array([@merch1, @merch2, @merch3, @merch4, @merch5, @merch6, @merch7, @merch8])

                @merch1.update(status: 1)
                @merch2.update(status: 1)

                expect(Merchant.enabled_merchants).to match_array([@merch1, @merch2])
                expect(Merchant.disabled_merchants).to match_array([@merch3, @merch4, @merch5, @merch6, @merch7, @merch8])
            end
        end
  end
end
