require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items)}
    it { should have_many(:bulk_discounts).through(:merchants)}
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
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoices[0], unit_price: 3011, quantity: 2, status: 2)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoices[0], unit_price: 2524, quantity: 1, status: 1)
      invoice_item3 = create(:invoice_item, item: item2, invoice: invoices[1], unit_price: 2524, status: 0)
      invoice_item4 = create(:invoice_item, item: item2, invoice: invoices[2], unit_price: 2524, status: 1)
      invoice_item5 = create(:invoice_item, item: item2, invoice: invoices[3], unit_price: 2524, status: 2)

      expect(invoices[0].total_revenue).to eq(8546)
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

    it "can calculate all of the invoices total revenue including discounted" do
      merchant1 = create(:merchant, name: "Jimmy")
      merchant2 = create(:merchant, name: "Phillip")
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      item1 = create(:item, merchant: merchant1, name: "Toy")
      item2 = create(:item, merchant: merchant1, name: "Lightsaber")
      item3 = create(:item, merchant: merchant2, name: "Jetpack")
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 15, unit_price: 100)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 10, unit_price: 500)
      invoice_item3 = create(:invoice_item, item: item3, invoice: invoice1, quantity: 20, unit_price: 700)
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 20)
      bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)
      bulk_discount3 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 40)
      bulk_discount4 = merchant1.bulk_discounts.create!(threshold: 20, discount_percentage: 30)
      bulk_discount5 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)
      bulk_discount6 = merchant2.bulk_discounts.create!(threshold: 15, discount_percentage: 30)

      expect(invoice1.all_invoice_revenue).to eq(15700)
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
