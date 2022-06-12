require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_one(:merchant).through(:item)}
    it { should have_many(:bulk_discounts).through(:merchant)}
  end

  describe 'validations' do
    it { should validate_numericality_of :quantity}
    it { should validate_numericality_of :unit_price}
    it { should define_enum_for(:status).with_values(["pending", "packaged", "shipped"])}
  end

  describe "#instance methods" do
    it "#unit_price_converted shows unit price as a currency format" do
      merchant1 = create(:merchant)
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011 )

      expect(invoice_item1.unit_price_converted).to eq("$30.11")
    end

    it "calculates total revenue before discount is applied" do
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

      expect(invoice_item1.revenue_before_discount).to eq(1200)
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

      expect(invoice_1).to eq(nil)
    end
  end
end
