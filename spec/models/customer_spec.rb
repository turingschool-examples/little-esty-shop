require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'associations' do
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  describe "instance methods" do
    before :each do
      @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
      @merch_2 = Merchant.create(name: "Klein, Rempel and Jones")

      @item_1 = @merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
      @item_2 = @merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
      @item_3 = @merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
      @item_4 = @merch_1.items.create!(name: "Double Legged Pant", description: "pants built for people with two legs", unit_price: 50000)
      @item_5 = @merch_1.items.create!(name: "Stainless Steel, 5-Pocket Jean", description: "Shorts of Steel", unit_price: 3000000)
      @item_6 = @merch_1.items.create!(name: "String of Numbers", description: "54921752964273", unit_price: 100)
      @item_7 = @merch_2.items.create!(name: "Shirt", description: "shirt for people", unit_price: 50000)

      @cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
      @cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
      @cust_3 = Customer.create!(first_name: "Brian", last_name: "Twinlegs")
      @cust_4 = Customer.create!(first_name: "Jared", last_name: "Goffleg")
      @cust_5 = Customer.create!(first_name: "Pistol", last_name: "Pete")
      @cust_6 = Customer.create!(first_name: "Bronson", last_name: "Shmonson")
      @cust_7 = Customer.create!(first_name: "Anten", last_name: "Branden")
      @cust_8 = Customer.create!(first_name: "Anthony", last_name: "Smith")
      
      @invoice_1 = @cust_1.invoices.create!(status: 1)
      @invoice_2 = @cust_1.invoices.create!(status: 1)
      @invoice_3 = @cust_1.invoices.create!(status: 1)
      @invoice_4 = @cust_2.invoices.create!(status: 1)
      @invoice_5 = @cust_2.invoices.create!(status: 1)
      @invoice_6 = @cust_2.invoices.create!(status: 1)
      @invoice_7 = @cust_3.invoices.create!(status: 1)
      @invoice_8 = @cust_3.invoices.create!(status: 1)
      @invoice_9 = @cust_4.invoices.create!(status: 1)
      @invoice_10 = @cust_5.invoices.create!(status: 1)
      @invoice_11 = @cust_5.invoices.create!(status: 1)
      @invoice_12 = @cust_6.invoices.create!(status: 1)
      @invoice_13 = @cust_6.invoices.create!(status: 1)
      @invoice_14 = @cust_7.invoices.create!(status: 1)
      @invoice_15 = @cust_7.invoices.create!(status: 2)
      @invoice_16 = @cust_7.invoices.create!(status: 2)
      @invoice_17 = @cust_8.invoices.create!(status: 1)
      
      @ii_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_4 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_5 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_6 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_7 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_7.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_8 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_9 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_9.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_10 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_10.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      
      @ii_11 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_11.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_12 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_12.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_13 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_13.id, quantity: 1, unit_price: @item_1.unit_price, status: 2)
      @ii_14 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_14.id, quantity: 500, unit_price: @item_4.unit_price, status: 2)
      @ii_15 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_14.id, quantity: 1, unit_price: @item_4.unit_price, status: 2)
      @ii_16 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_1.unit_price, status: 2)
      @ii_17 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_2.unit_price, status: 2)
      @ii_18 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_14.id, quantity: 30, unit_price: @item_3.unit_price, status: 2)
      @ii_19 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_15.id, quantity: 700, unit_price: @item_5.unit_price, status: 2)
      @ii_20 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_16.id, quantity: 700, unit_price: @item_7.unit_price, status: 2)
      @ii_21 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_17.id, quantity: 300, unit_price: @item_7.unit_price, status: 2)
      
      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4039485738495837, credit_card_expiration_date: "1", result: "success")
      @transaction_2 = @invoice_2.transactions.create!(credit_card_number: 4039485738495837, credit_card_expiration_date: "1", result: "success")
      @transaction_3 = @invoice_3.transactions.create!(credit_card_number: 4039485738495837, credit_card_expiration_date: "1", result: "success")
      @transaction_4 = @invoice_4.transactions.create!(credit_card_number: 4847583748374837, credit_card_expiration_date: "1", result: "success")
      @transaction_5 = @invoice_5.transactions.create!(credit_card_number: 4847583748374837, credit_card_expiration_date: "1", result: "success")
      @transaction_6 = @invoice_6.transactions.create!(credit_card_number: 4847583748374837, credit_card_expiration_date: "1", result: "success")
      @transaction_7 = @invoice_7.transactions.create!(credit_card_number: 4364756374652636, credit_card_expiration_date: "1", result: "success")
      @transaction_8 = @invoice_8.transactions.create!(credit_card_number: 4364756374652636, credit_card_expiration_date: "1", result: "success")
      @transaction_9 = @invoice_9.transactions.create!(credit_card_number: 4928294837461125, credit_card_expiration_date: "1", result: "success")
      @transaction_10 = @invoice_10.transactions.create!(credit_card_number: 4928294837461125, credit_card_expiration_date: "1", result: "success")
      @transaction_11 = @invoice_11.transactions.create!(credit_card_number: 4738473664751832, credit_card_expiration_date: "1", result: "success")
      @transaction_12 = @invoice_12.transactions.create!(credit_card_number: 4738473664751832, credit_card_expiration_date: "1", result: "success")
      @transaction_13 = @invoice_13.transactions.create!(credit_card_number: 4023948573948293, credit_card_expiration_date: "1", result: "success")
      @transaction_14 = @invoice_14.transactions.create!(credit_card_number: 4023948573948293, credit_card_expiration_date: "1", result: "failure")
      @transaction_15 = @invoice_15.transactions.create!(credit_card_number: 4023948573948293, credit_card_expiration_date: "1", result: "success")
      @transaction_16 = @invoice_17.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
    end

    describe "#total_transactions_with_merchant(merch_id)" do
      it "returns the number of successful transactions the customer has had with a merchant" do
        expect(@cust_7.successful_transactions_with_merchant(@merch_1)).to eq(1)
        expect(@cust_1.successful_transactions_with_merchant(@merch_1)).to eq(3)
      end
    end

    describe 'top 5 customers' do
      it 'returns the 5 customers with the most successful transactions' do
        @invoice_18 = @cust_1.invoices.create!(status: 1)
        @invoice_19 = @cust_1.invoices.create!(status: 1)
        @invoice_20 = @cust_1.invoices.create!(status: 1)
        @invoice_21 = @cust_2.invoices.create!(status: 1)
        @invoice_22 = @cust_2.invoices.create!(status: 1)
        @invoice_23 = @cust_3.invoices.create!(status: 1)
        @invoice_24 = @cust_3.invoices.create!(status: 1)
        @invoice_25 = @cust_6.invoices.create!(status: 1)

        @transaction_17 = @invoice_18.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
        @transaction_18 = @invoice_19.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
        @transaction_19 = @invoice_20.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
        @transaction_20 = @invoice_21.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
        @transaction_21 = @invoice_22.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
        @transaction_22 = @invoice_23.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
        @transaction_23 = @invoice_24.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")
        @transaction_24 = @invoice_25.transactions.create!(credit_card_number: 4023948573948394, credit_card_expiration_date: "1", result: "success")

        expected = [@cust_1, @cust_2, @cust_3, @cust_6, @cust_5]
        top_5 = Customer.top_5_by_successful_transactions
        expect(expected).to eq(top_5)
      end

      it 'can return a customers number of successful transactions' do
        expect(@cust_1.successful_transactions).to eq(3)
      end
    end
  end
end