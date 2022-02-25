require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  before (:each) do
    @merchant_1 = Merchant.create!(name: "Staples")
    @merchant_2 = Merchant.create!(name: "Dunder Miflin")

    @item_1 = @merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)
    @item_2 = @merchant_1.items.create!(name: "paper", description: "construction", unit_price: 29)
    @item_3 = @merchant_2.items.create!(name: "calculator", description: "TI-84", unit_price: 84)
    @item_4 = @merchant_2.items.create!(name: "paperclips", description: "24 Count", unit_price: 25)

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
    @transcation_2 = @invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "failed")
    @transcation_3 = @invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "success")
    @transcation_4 = @invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "failed")
    @transcation_5 = @invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "success")
    @transcation_6 = @invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "failed")
    @transcation_7 = @invoice_7.transactions.create!(credit_card_number: "4654405418249639", result: "success")
    @transcation_8 = @invoice_8.transactions.create!(credit_card_number: "4654405418249630", result: "failed")
    @transcation_9 = @invoice_9.transactions.create!(credit_card_number: "4654405418249612", result: "success")
    @transcation_10 = @invoice_10.transactions.create!(credit_card_number: "4654405418249613", result: "failed")
    @transcation_11 = @invoice_11.transactions.create!(credit_card_number: "4654405418249614", result: "success")
    @transcation_12 = @invoice_12.transactions.create!(credit_card_number: "4654405418249635", result: "failed")
  end

  describe 'instance methods' do
    it "can return its full name" do
      expect(@customer_1.name).to eq("Person 1 Mcperson 1")
    end
  end
end

RSpec.describe Customer do
  describe "class methods" do
    it "can return the top 5 customers" do
      customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
      customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
      customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
      customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
      customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
      customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")

      invoice_1 = customer_1.invoices.create!(status: "completed")
      invoice_2 = customer_1.invoices.create!(status: "completed")
      invoice_3 = customer_2.invoices.create!(status: "completed")
      invoice_4 = customer_2.invoices.create!(status: "completed")
      invoice_5 = customer_2.invoices.create!(status: "completed")
      invoice_6 = customer_3.invoices.create!(status: "completed")
      invoice_7 = customer_3.invoices.create!(status: "completed")
      invoice_8 = customer_3.invoices.create!(status: "completed")
      invoice_9 = customer_4.invoices.create!(status: "completed")
      invoice_10 = customer_4.invoices.create!(status: "completed")
      invoice_11 = customer_5.invoices.create!(status: "completed")
      invoice_12 = customer_5.invoices.create!(status: "completed")
      invoice_13 = customer_6.invoices.create!(status: "completed")
      invoice_14 = customer_6.invoices.create!(status: "completed")

      transcation_1 = invoice_1.transactions.create!(credit_card_number: "4654405418249632", result: "success")
      transcation_2 = invoice_2.transactions.create!(credit_card_number: "4654405418249634", result: "success")
      transcation_3 = invoice_3.transactions.create!(credit_card_number: "4654405418249635", result: "failed")
      transcation_4 = invoice_4.transactions.create!(credit_card_number: "4654405418249636", result: "failed")
      transcation_5 = invoice_5.transactions.create!(credit_card_number: "4654405418249637", result: "success")
      transcation_6 = invoice_6.transactions.create!(credit_card_number: "4654405418249638", result: "success")
      transcation_7 = invoice_7.transactions.create!(credit_card_number: "4654405418249639", result: "success")
      transcation_8 = invoice_8.transactions.create!(credit_card_number: "4654405418249630", result: "success")
      transcation_9 = invoice_9.transactions.create!(credit_card_number: "4654405418249612", result: "success")
      transcation_10 = invoice_10.transactions.create!(credit_card_number: "4654405418249613", result: "success")
      transcation_11 = invoice_11.transactions.create!(credit_card_number: "4654405418249614", result: "success")
      transcation_12 = invoice_12.transactions.create!(credit_card_number: "4654405418249635", result: "success")
      transcation_13 = invoice_13.transactions.create!(credit_card_number: "4654405418249635", result: "success")
      transcation_14 = invoice_14.transactions.create!(credit_card_number: "4654405418249635", result: "success")

      expect(Customer.top_five).to eq([customer_3, customer_1, customer_4, customer_5, customer_6])
    end
  end
end
