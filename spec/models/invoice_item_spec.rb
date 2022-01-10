require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'enums validation' do
    it {should define_enum_for(:status).with([:pending, :packaged, :shipped])}
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity)}
    it { should validate_numericality_of(:quantity)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_numericality_of(:unit_price)}
  end

  describe 'instance methods' do
    describe 'revenue' do
      it "multiplies unit_price and quantity" do
        invoice_item = create(:invoice_item, quantity: 3, unit_price: 1000)
        expect(invoice_item.revenue).to eq(3000)
      end
    end
  end

  describe 'class methods' do
    describe 'revenue' do
      it "multiplies unit_price and quantity for a collection of invoice_items and sums them" do
        invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 1000)
        invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 1000)
        invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1000)
        invoice_items_array = [invoice_item_1, invoice_item_2, invoice_item_3]
        invoices = InvoiceItem.where(id: invoice_items_array.map(&:id))
        expect(invoices.revenue).to eq(9000)
      end
    end

    describe 'potential_revenue' do
      it "multiplies unit_price and quantity for a collection of invoice_items and sums them only if they are associated with an invoice that has at least 1 successful transaction" do
        invoice_1 = create(:invoice)
        invoice_2 = create(:invoice)
        invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 1000, invoice: invoice_1)
        invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 1000, invoice: invoice_1)
        invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1000, invoice: invoice_2)
        invoice_items_array = [invoice_item_1, invoice_item_2, invoice_item_3]
        invoices = InvoiceItem.where(id: invoice_items_array.map(&:id))

        # test for no transactions
        expect(invoices.revenue).to eq(0)

        # test for no successful transactions.
        transaction_1 = create(:transaction, result: 1, invoice: invoice_1)
        expect(invoices.revenue).to eq(0)

        # test for successful transactions
        transaction_2 = create(:transaction, result: 0, invoice: invoice_1)
        expect(invoices.revenue).to eq(8000)

        # test for multiple invoices with successful transactions
        transaction_3 = create(:transaction, result: 0, invoice: invoice_2)
        expect(invoices.revenue).to eq(9000)
      end
    end
  end
end
