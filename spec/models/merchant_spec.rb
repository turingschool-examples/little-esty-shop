require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it {should define_enum_for(:status).with([:Disabled, :Enabled])}
  end

  describe 'class methods' do
    it 'reports a merchants invoices' do
      merchant1 = create(:merchant)
      invoice1 = create(:invoice)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      expect(merchant1.invoice_finder).to eq [invoice1]
    end

    it '#enabled_merchants' do
      merchant1 = create(:merchant, name: "Matthew", status: 1)
      merchant2 = create(:merchant, name: "Mark", status: 1)
      merchant3 = create(:merchant, name: "Luke")
      merchant4 = create(:merchant, name: "John")

      expect(Merchant.enabled_merchants).to eq([merchant1, merchant2])
    end
    #this test below needs to be rewritten to pass.  the method works but it is returning merchants outside the scope of the test
    it "disabled_merchants" do
      merchant1 = create(:merchant, name: "Matthew", status: 1)
      merchant2 = create(:merchant, name: "Mark", status: 1)
      merchant3 = create(:merchant, name: "Luke")
      merchant4 = create(:merchant, name: "John")

      expect(Merchant.disabled_merchants).to eq([merchant3, merchant4])
    end

    describe 'top_merchants' do
      it "returns the top merchants ordered by revenue" do
        merchant_1 = create(:merchant_with_transactions, name: 'Zach', invoice_item_quantity: 3, invoice_item_unit_price: 10)
        merchant_2 = create(:merchant_with_transactions, name: 'Abe', invoice_item_quantity: 15, invoice_item_unit_price: 100000)
        merchant_3 = create(:merchant_with_transactions, name: 'Nobody', invoice_item_quantity: 3, invoice_item_unit_price: 1)
        merchant_4 = create(:merchant_with_transactions, name: 'Jenny', invoice_item_quantity: 3, invoice_item_unit_price: 100)
        merchant_5 = create(:merchant_with_transactions, name: 'Bob', invoice_item_quantity: 3, invoice_item_unit_price: 10000)
        merchant_6 = create(:merchant_with_transactions, name: 'Charlie', invoice_item_quantity: 3, invoice_item_unit_price: 1000)

        expect(Merchant.top_merchants(1)).to eq([merchant_2])
        expect(Merchant.top_merchants(2)).to eq([merchant_2, merchant_5])

        # Create new items to test top_merchants across multiple invoices for one merchant.
        # Test with invalid transaction.
        invoice_1 = create(:invoice_with_transactions, transaction_result: 1)
        new_items = create(:item_with_transactions, merchant: merchant_6, invoice: invoice_1, invoice_item_quantity: 15, invoice_item_unit_price: 100000, transaction_result: 1)

        expect(Merchant.top_merchants(2)).to eq([merchant_2, merchant_5])

        # Test with valid transaction.
        new_items = create(:item_with_transactions, merchant: merchant_6, invoice_item_quantity: 15, invoice_item_unit_price: 100000, transaction_result: 0)
        expect(Merchant.top_merchants(2)).to eq([merchant_6, merchant_2])
      end
    end
  end

  describe 'instance methods' do
    describe 'top_customers' do
      it 'returns an array of the top customers based on the number of thier number completed transactions for the merchants items' do
        merchant = create(:merchant)

        customer_1 = create(:customer_with_transactions, merchant: merchant, transaction_result: 0, transaction_count: 6, first_name: 'Bob')
        customer_2 = create(:customer_with_transactions, merchant: merchant, transaction_result: 0, transaction_count: 3, first_name: 'John')
        customer_3 = create(:customer_with_transactions, merchant: merchant, transaction_result: 0, transaction_count: 8, first_name: 'Abe')
        customer_4 = create(:customer_with_transactions, merchant: merchant, transaction_result: 0, transaction_count: 1, first_name: 'Zach')
        customer_5 = create(:customer_with_transactions, merchant: merchant, transaction_result: 0, transaction_count: 4, first_name: 'Charlie')

        expect(merchant.top_customers(1)).to eq([customer_3])
        expect(merchant.top_customers(2)).to eq([customer_3, customer_1])
        expect(merchant.top_customers(5)).to eq([customer_3, customer_1, customer_5, customer_2, customer_4])
        expect(merchant.top_customers(6)).to eq([customer_3, customer_1, customer_5, customer_2, customer_4])
      end
    end

    describe 'items_ready_to_ship' do
      it "returns a list of all items with an invoice_item status of 0 or 1" do
        merchant = create(:merchant)
        item_1 = create(:item_with_invoices, merchant: merchant, invoice_item_status: 0)
        item_2 = create(:item_with_invoices, merchant: merchant, invoice_item_status: 1)
        item_3 = create(:item_with_invoices, merchant: merchant, invoice_item_status: 1)
        item_4 = create(:item_with_invoices, merchant: merchant, invoice_item_status: 2)

        expect(merchant.items_ready_to_ship).to eq([item_1, item_2, item_3])
      end

      it "returns items in descending order based on created_at date" do
        merchant = create(:merchant)
        invoice_1 = create(:invoice, created_at: Date.new(2022, 4, 20))
        invoice_2 = create(:invoice, created_at: Date.new(2022, 1, 12))
        invoice_3 = create(:invoice, created_at: Date.new(2022, 3, 2))
        item_1 = create(:item_with_invoices, merchant: merchant, invoices: [invoice_1])
        item_2 = create(:item_with_invoices, merchant: merchant, invoices: [invoice_2])
        item_3 = create(:item_with_invoices, merchant: merchant, invoices: [invoice_3])

        expect(merchant.items_ready_to_ship).to eq([item_2, item_3, item_1])
      end
    end

    describe 'popular_items' do
      it "returns a list of items ordered by potential_reveneu" do
        merchant = create(:merchant)
        item_1 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice_item_quantity: 4, invoice_item_unit_price: 1000)
        item_2 = create(:item_with_transactions, merchant: merchant, name: "Apple", invoice_item_quantity: 4, invoice_item_unit_price: 1000000)
        item_3 = create(:item_with_transactions, merchant: merchant, name: "Zebra", invoice_item_quantity: 4, invoice_item_unit_price: 100)
        item_4 = create(:item_with_transactions, merchant: merchant, name: "Bus", invoice_item_quantity: 4, invoice_item_unit_price: 100000)
        item_5 = create(:item_with_transactions, merchant: merchant, name: "Dog", invoice_item_quantity: 4, invoice_item_unit_price: 10000)
        item_6 = create(:item_with_transactions, merchant: merchant, name: "Legos", invoice_item_quantity: 4000, invoice_item_unit_price: 100000, transaction_result: 1)

        expected = [item_2, item_4, item_5, item_1, item_3]

        expect(merchant.popular_items(5)).to eq(expected)
      end
    end

    describe 'best_day' do
      it "returns the created_at date of the invoice associated with the highest total revenue" do
        merchant = create(:merchant)
        invoice_1 = create(:invoice, created_at: DateTime.new(2022, 1, 10, 1, 1, 1))
        item_1 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice: invoice_1, invoice_item_quantity: 4, invoice_item_unit_price: 100000)
        expect(merchant.best_day).to eq(DateTime.new(2022, 1, 10, 1, 1, 1))

        #create a smaller invoice that should not affect top date
        invoice_2 = create(:invoice, created_at: DateTime.new(2022, 1, 11, 1, 1, 1))
        item_2 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice: invoice_2, invoice_item_quantity: 2, invoice_item_unit_price: 1000)
        expect(merchant.best_day).to eq(DateTime.new(2022, 1, 10, 1, 1, 1))

        #create an equal revenue invoice that should not affect top date becuase it is older
        invoice_3 = create(:invoice, created_at: DateTime.new(2022, 1, 5, 1, 1, 1))
        item_3 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice: invoice_3, invoice_item_quantity: 4, invoice_item_unit_price: 100000)
        expect(merchant.best_day).to eq(DateTime.new(2022, 1, 10, 1, 1, 1))

        #create an higher revenue invoice that should  affect top date becuase it has more revenue
        invoice_3 = create(:invoice, created_at: DateTime.new(2022, 1, 12, 1, 1, 1))
        item_3 = create(:item_with_transactions, merchant: merchant, name: "Toy", invoice: invoice_3, invoice_item_quantity: 5, invoice_item_unit_price: 100000)
        expect(merchant.best_day).to eq(DateTime.new(2022, 1, 12, 1, 1, 1))
      end
    end

    describe "successful_transactions" do
      it "returns the count of successful transactions" do
        merchant_1 = create(:merchant_with_transactions, transaction_count: 5, transaction_result: 0)
        merchant_2 = create(:merchant_with_transactions, transaction_count: 5, transaction_result: 1)

        expect(merchant_1.successful_transactions).to eq(5)
        expect(merchant_2.successful_transactions).to eq(0)

        # create transactions that should nto show up.
        merchant_3 = create(:merchant_with_transactions, transaction_count: 5, transaction_result: 1)
        merchant_3.items.update(merchant: merchant_1)

        expect(merchant_1.successful_transactions).to eq(5)
      end
    end
  end
end
