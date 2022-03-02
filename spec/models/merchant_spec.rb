require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end

  before (:each) do
    @merchant_1 = Merchant.create!(name: "Staples")
    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @item_3 = @merchant_1.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_1.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)

    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
    @customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
    @customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
    @customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
    @customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")
    # status assigned evenly spread around, not sure if we should adjust for different amounts of each
    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_3 = @customer_2.invoices.create!(status: "in progress")
    @invoice_4 = @customer_2.invoices.create!(status: "completed")
    @invoice_5 = @customer_2.invoices.create!(status: "cancelled")
    @invoice_6 = @customer_3.invoices.create!(status: "in progress")
    @invoice_7  = @customer_3.invoices.create!(status: "completed")
    @invoice_8 = @customer_3.invoices.create!(status: "cancelled")
    @invoice_9 = @customer_4.invoices.create!(status: "in progress")
    @invoice_10 = @customer_4.invoices.create!(status: "completed")
    @invoice_11 = @customer_5.invoices.create!(status: "cancelled")
    @invoice_12 = @customer_6.invoices.create!(status: "in progress")
    #for now unit prices match between items and invoice_items, may want to adjust as testing requires
    @invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 13, status: "shipped")
    @invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 2, unit_price: 29, status: "packaged")
    @invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 3, unit_price: 84, status: "pending")
    @invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 4, unit_price: 25, status: "shipped")
    @invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_1.id, quantity: 5, unit_price: 13, status: "packaged")
    @invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_2.id, quantity: 6, unit_price: 29, status: "pending")
    @invoice_item_7 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_3.id, quantity: 1, unit_price: 84, status: "shipped")
    @invoice_item_8 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_4.id, quantity: 2, unit_price: 25, status: "packaged")
    @invoice_item_9 = InvoiceItem.create!(invoice_id: @invoice_9.id, item_id: @item_1.id, quantity: 3, unit_price: 13, status: "pending")
    @invoice_item_10 = InvoiceItem.create!(invoice_id: @invoice_10.id, item_id: @item_2.id, quantity: 4, unit_price: 29, status: "shipped")
    @invoice_item_11 = InvoiceItem.create!(invoice_id: @invoice_11.id, item_id: @item_3.id, quantity: 5, unit_price: 84, status: "packaged")
    @invoice_item_12 = InvoiceItem.create!(invoice_id: @invoice_12.id, item_id: @item_4.id, quantity: 6, unit_price: 25, status: "pending")
    # result assigned evenly spread around, not sure if we should adjust for different amounts of each
    @transcation_1 = @invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
    @transcation_2 = @invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
    @transcation_3 = @invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    @transcation_4 = @invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
    @transcation_5 = @invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "success")
    @transcation_6 = @invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "success")
    @transcation_7 = @invoice_7.transactions.create!(credit_card_number: "4654405418249639", result: "success")
    @transcation_8 = @invoice_8.transactions.create!(credit_card_number: "4654405418249630", result: "success")
    @transcation_9 = @invoice_9.transactions.create!(credit_card_number: "4654405418249612", result: "success")
    @transcation_10 = @invoice_10.transactions.create!(credit_card_number: "4654405418249613", result: "success")
    @transcation_11 = @invoice_11.transactions.create!(credit_card_number: "4654405418249614", result: "success")
    @transcation_12 = @invoice_12.transactions.create!(credit_card_number: "4654405418249635", result: "failed")
  end

  describe 'instance methods' do
    it ".unique_invoices" do
      expect(@merchant_1.unique_invoices).to eq([
                                                  @invoice_1,
                                                  @invoice_2,
                                                  @invoice_3,
                                                  @invoice_4,
                                                  @invoice_5,
                                                  @invoice_6,
                                                  @invoice_7,
                                                  @invoice_8,
                                                  @invoice_9,
                                                  @invoice_10,
                                                  @invoice_11,
                                                  @invoice_12,
                                                  ])
    end
    it '.ship_ready_items' do
      expect(@merchant_1.ship_ready_items).to eq([
                                                  @invoice_item_2,
                                                  @invoice_item_3,
                                                  @invoice_item_5,
                                                  @invoice_item_6,
                                                  @invoice_item_8,
                                                  @invoice_item_9,
                                                  @invoice_item_11,
                                                  @invoice_item_12
                                                  ])
    end

    it ".top_five_customers" do
      expect(@merchant_1.top_five_customers).to eq([@customer_2,
                                                    @customer_3,
                                                    @customer_1,
                                                    @customer_4,
                                                    @customer_5
                                                    ])
    end


    it 'knows a merchants best day' do

      # As an admin,
      # When I visit the admin merchants index
      # Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
      # And I see a label “Top selling date for was "
      #
      # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.

      merchant_1 = Merchant.create!(name: "Staples")
      merchant_2 = Merchant.create!(name: "Here store")

      customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
      item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
      item_2 = merchant_2.items.create!(name: "stuff", description: "does things", unit_price: 10)
      invoice_1 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 22))##
      invoice_2 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 23))##
      invoice_3 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 24))##
      invoice_4 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 25))##
      invoice_5 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 26))##
      invoice_6 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2022, 2, 27))##
      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 1, status: "shipped")
      invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_1.id, quantity: 1, unit_price: 2, status: "shipped")
      invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_1.id, quantity: 1, unit_price: 3, status: "shipped")
      invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: "shipped")
      invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_2.id, quantity: 1, unit_price: 20, status: "shipped")
      invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_2.id, quantity: 1, unit_price: 30, status: "shipped")
      invoice_9 = customer_1.invoices.create!(status: "completed", created_at: DateTime.new(2021, 12, 18))
      invoice_item_9 = InvoiceItem.create!(invoice_id: invoice_9.id, item_id: item_1.id, quantity: 1, unit_price: 1, status: "shipped")
      transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
      transcation_2 = invoice_9.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_3 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_4 = invoice_3.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_4 = invoice_5.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_4 = invoice_6.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      expect(merchant_1.best_sales_day).to eq(DateTime.new(2022, 2, 24))
      expect(merchant_2.best_sales_day).to eq(DateTime.new(2022, 2, 27))

    end

    it "orders each merchant's item by its revenue" do
      merchant_1 = Merchant.create!(name: "Staples")

      item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
      item_2 = merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
      item_3 = merchant_1.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
      item_4 = merchant_1.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
      item_5 = merchant_1.items.create!(name: "pencil", description: "24 Count", unit_price: 35)
      item_6 = merchant_1.items.create!(name: "fountain pen", description: "24 Count", unit_price: 45)
      item_7 = merchant_1.items.create!(name: "Sticky Notes", description: "24 Count", unit_price: 55)
      item_8 = merchant_1.items.create!(name: "Scissors", description: "2 Count", unit_price: 22)

      customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
      customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
      customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
      customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
      customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
      customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")
      customer_7 = Customer.create!(first_name: "Person 7", last_name: "Mcperson 7")
      customer_8 = Customer.create!(first_name: "Person 8", last_name: "Mcperson 8")

      invoice_1 = customer_1.invoices.create!(status: "completed")
      invoice_2 = customer_2.invoices.create!(status: "cancelled")
      invoice_3 = customer_3.invoices.create!(status: "in progress")
      invoice_4 = customer_4.invoices.create!(status: "completed")
      invoice_5 = customer_5.invoices.create!(status: "cancelled")
      invoice_6 = customer_6.invoices.create!(status: "in progress")
      invoice_7 = customer_7.invoices.create!(status: "in progress")
      invoice_8 = customer_8.invoices.create!(status: "in progress")

      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 13, status: "shipped")
      invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 2, unit_price: 29, status: "packaged") #*
      invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 3, unit_price: 84, status: "pending") #*
      invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 4, unit_price: 25, status: "shipped") #*
      invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 55, unit_price: 83, status: "packaged")
      invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 65, unit_price: 92, status: "pending")
      invoice_item_7 = InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 5, unit_price: 29, status: "pending") #*
      invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 5, unit_price: 29, status: "pending") #*

      transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
      transcation_2 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_3 = invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
      transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
      transcation_5 = invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "failed")
      transcation_6 = invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "failed")
      transcation_7 = invoice_7.transactions.create!(credit_card_number: "4654405418249638", result: "success")
      transcation_8 = invoice_8.transactions.create!(credit_card_number: "4654405418249638", result: "success")

      expect(merchant_1.top_five_items).to eq([item_3,
                                                item_7,
                                                item_8,
                                                item_4,
                                                item_2
                                                ])
    end
  end

  describe 'class methods' do
    it "returns top 5 merchants by total revenue" do
      customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

      invoice_1 = customer_1.invoices.create!(status: "completed")
      invoice_2 = customer_1.invoices.create!(status: "cancelled")
      invoice_3 = customer_1.invoices.create!(status: "in progress")
      invoice_4 = customer_1.invoices.create!(status: "completed")
      invoice_5 = customer_1.invoices.create!(status: "cancelled")
      invoice_6 = customer_1.invoices.create!(status: "in progress")
      invoice_7 = customer_1.invoices.create!(status: "completed")
      invoice_8 = customer_1.invoices.create!(status: "cancelled")

      transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
      transcation_2 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_3 = invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
      transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "success")
      transcation_5 = invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "failed")
      transcation_6 = invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "failed")
      transcation_7 = invoice_7.transactions.create!(credit_card_number: "4654405418249638", result: "success")
      transcation_8 = invoice_8.transactions.create!(credit_card_number: "4654405418249638", result: "success")

      merchant_1 = Merchant.create!(name: "Staples")
      merchant_2 = Merchant.create!(name: "Home Depot")
      merchant_3 = Merchant.create!(name: "Office Depot")
      merchant_4 = Merchant.create!(name: "Lowes")
      merchant_5 = Merchant.create!(name: "Frys")
      merchant_6 = Merchant.create!(name: "Sears")
      merchant_7 = Merchant.create!(name: "Walmart")
      merchant_8 = Merchant.create!(name: "Target")

      item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
      item_2 = merchant_2.items.create!(name: "paper", description: "construction", unit_price: 29)
      item_3 = merchant_3.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
      item_4 = merchant_4.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)
      item_5 = merchant_5.items.create!(name: "pencil", description: "24 Count", unit_price: 35)
      item_6 = merchant_6.items.create!(name: "fountain pen", description: "24 Count", unit_price: 45)
      item_7 = merchant_7.items.create!(name: "Sticky Notes", description: "24 Count", unit_price: 55)
      item_8 = merchant_8.items.create!(name: "Scissors", description: "2 Count", unit_price: 22)

      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 5, status: "shipped")
      invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: "shipped")
      invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 15, status: "shipped")
      invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 20, status: "shipped")
      invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 25, status: "shipped")
      invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 30, status: "shipped")
      invoice_item_7 = InvoiceItem.create!(invoice_id: invoice_7.id, item_id: item_7.id, quantity: 1, unit_price: 35, status: "shipped")
      invoice_item_8 = InvoiceItem.create!(invoice_id: invoice_8.id, item_id: item_8.id, quantity: 1, unit_price: 40, status: "shipped")

      expect(Merchant.top_five_merchants).to eq([@merchant_1,
                                                merchant_8,
                                                merchant_7,
                                                merchant_4,
                                                merchant_3,
                                                ])
    end
  end
end
