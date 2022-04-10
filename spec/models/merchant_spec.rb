require "rails_helper"

RSpec.describe Merchant do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description:, "pants built for people with two legs", unit_price: 5000)
    @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description:, "shorts built for people with two legs", unit_price: 3000)
    @item_3 = @merch_1.items.create!(name: "Hat", description:, "hat built for people with two legs and one head", unit_price: 6000)

    @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
    @cust_2 = Cuustomer.create!(first_name: "Tommy", last_name: "Doubleleg")
    @cust_3 = Cuustomer.create!(first_name: "Tommy", last_name: "Doubleleg")
    @cust_4 = Cuustomer.create!(first_name: "Tommy", last_name: "Doubleleg")
    @cust_5 = Cuustomer.create!(first_name: "Tommy", last_name: "Doubleleg")
    @cust_6 = Cuustomer.create!(first_name: "Tommy", last_name: "Doubleleg")

    @invoice_1 = @cust_1.invoices.create!(status: "1")
    @invoice_2 = @cust_1.invoices.create!(status: "1")
    @invoice_3 = @cust_1.invoices.create!(status: "1")
    @invoice_4 = @cust_2.invoices.create!(status: "1")
    @invoice_5 = @cust_2.invoices.create!(status: "1")
    @invoice_6 = @cust_2.invoices.create!(status: "1")
    @invoice_7 = @cust_3.invoices.create!(status: "1")
    @invoice_8 = @cust_3.invoices.create!(status: "1")
    @invoice_9 = @cust_4.invoices.create!(status: "1")
    @invoice_10 = @cust_4.invoices.create!(status: "1")
    @invoice_11 = @cust_5.invoices.create!(status: "1")
    @invoice_12 = @cust_5.invoices.create!(status: "1")
    @invoice_13 = @cust_6.invoices.create!(status: "1")

    @item_1.invoices << @invoice_1
    @item_1.invoices << @invoice_2
    @item_1.invoices << @invoice_3
    @item_1.invoices << @invoice_4
    @item_1.invoices << @invoice_5
    @item_1.invoices << @invoice_6
    @item_1.invoices << @invoice_7
    @item_1.invoices << @invoice_8
    @item_1.invoices << @invoice_9
    @item_1.invoices << @invoice_10
    @item_1.invoices << @invoice_11
    @item_1.invoices << @invoice_12
    @item_1.invoices << @invoice_13

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4023948573948293, result: "success")

  end
  describe "relationships" do
    it { should have_many(:items) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe "instance methods" do
    it "returns top 5 customers by number of successful transactions " do
      expect(@merch_1.top_5_customers).to eq([@cust_1, @cust_2, @cust_3, @cust_4, @cust_5])
    end
  end
end
