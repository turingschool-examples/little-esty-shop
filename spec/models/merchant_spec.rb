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
  end

  describe 'class methods' do
    it 'reports a merchants invoices' do
      merchant1 = create(:merchant)
      invoice1 = create(:invoice)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      expect(merchant1.invoice_finder).to eq [invoice1]
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
    end
  end
end
