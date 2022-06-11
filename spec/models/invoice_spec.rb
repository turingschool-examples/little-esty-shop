require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values(['in progress', 'completed', 'cancelled']) }
  end

  describe '#instance methods' do
    it '#total_revenue returns total revenue of an invoice' do
      merchant1 = create(:merchant)
      customer1 = create(:customer)

      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)

      invoices = create_list(:invoice, 4, customer: customer1, created_at: "2022-03-10 00:54:09 UTC")

      transaction1 = create(:transaction, invoice: invoices[0], result: 1)

      invoice_item1 = create(:invoice_item, item: item1, invoice: invoices[0], unit_price: 3011, status: 2)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoices[0], unit_price: 2524, status: 1)
      invoice_item3 = create(:invoice_item, item: item2, invoice: invoices[1], unit_price: 2524, status: 0)
      invoice_item4 = create(:invoice_item, item: item2, invoice: invoices[2], unit_price: 2524, status: 1)
      invoice_item5 = create(:invoice_item, item: item2, invoice: invoices[3], unit_price: 2524, status: 2)

      expect(invoices[0].total_revenue).to eq('$55.35')
    end

    it 'formats the date correctly' do
      merchant1 = create(:merchant)
      customer1 = create(:customer)

      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)

      invoices = create_list(:invoice, 4, customer: customer1, created_at: "2022-03-10 00:54:09 UTC")

      transaction1 = create(:transaction, invoice: invoices[0], result: 1)

      invoice_item1 = create(:invoice_item, item: item1, invoice: invoices[0], unit_price: 3011, status: 2)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoices[0], unit_price: 2524, status: 1)
      invoice_item3 = create(:invoice_item, item: item2, invoice: invoices[1], unit_price: 2524, status: 0)
      invoice_item4 = create(:invoice_item, item: item2, invoice: invoices[2], unit_price: 2524, status: 1)
      invoice_item5 = create(:invoice_item, item: item2, invoice: invoices[3], unit_price: 2524, status: 2)

      expect(invoices[0].formatted_date).to eq('Thursday, March 10, 2022')
    end

    it "calculates total revenue with the bulk discount" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      invoice2 = create(:invoice, customer: customer1)
      transaction1 = create(:transaction, invoice: invoice1, result: 0)
      transaction2 = create(:transaction, invoice: invoice1, result: 0)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 15, unit_price: 200)
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 10, discount_percentage: 20)
      bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)


    end
  end

  describe ".class methods" do
    it 'returns all invoices without a shipped status' do
      merchant1 = create(:merchant)
      customer1 = create(:customer)

      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant1)

      invoices = create_list(:invoice, 4, customer: customer1, created_at: "2022-03-10 00:54:09 UTC")

      transaction1 = create(:transaction, invoice: invoices[0], result: 1)

      invoice_item1 = create(:invoice_item, item: item1, invoice: invoices[0], unit_price: 3011, status: 2)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoices[0], unit_price: 2524, status: 1)
      invoice_item3 = create(:invoice_item, item: item2, invoice: invoices[1], unit_price: 2524, status: 0)
      invoice_item4 = create(:invoice_item, item: item2, invoice: invoices[2], unit_price: 2524, status: 1)
      invoice_item5 = create(:invoice_item, item: item2, invoice: invoices[3], unit_price: 2524, status: 2)

      expect(Invoice.not_shipped).to eq([invoices[0], invoices[1], invoices[2]])
      expect(Invoice.not_shipped).to_not eq(invoices[3])
    end
  end
end
