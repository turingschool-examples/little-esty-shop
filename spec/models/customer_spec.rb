require 'rails_helper'

RSpec.describe Customer do
    describe "relationships" do
        it { should have_many :invoices }
        it { should have_many(:transactions).through(:invoices) }
    end

    describe "class methods" do
      it 'gives me the top five customers' do
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

        expect(Customer.top_five_by_transaction_count).to eq([@cust5, @cust3, @cust1, @cust2, @cust4])
      end
    end
end
