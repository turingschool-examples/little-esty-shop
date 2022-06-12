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
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100)

      expect(invoice_item1.revenue_before_discount).to eq(1200)
    end

    it "calculates total revenue with the bulk discount" do
      merchant1 = create(:merchant, name: "Jimmy")
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      invoice2 = create(:invoice, customer: customer1)
      item1 = create(:item, merchant: merchant1, name: "Toy")
      item2 = create(:item, merchant: merchant1, name: "Lightsaber")
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 15, unit_price: 100)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 10, unit_price: 500)
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 10, discount_percentage: 20)
      bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)
      bulk_discount3 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 40)
      bulk_discount4 = merchant1.bulk_discounts.create!(threshold: 20, discount_percentage: 30)
      bulk_discount5 = merchant1.bulk_discounts.create!(threshold: 10, discount_percentage: 30)

      expect(invoice_item1.find_discount).to eq(bulk_discount3)
      expect(invoice_item2.find_discount).to eq(bulk_discount5)
    end
  end

  it "it can apply discount and/or return revenue if no discount is applicabale " do
    merchant1 = create(:merchant, name: "Jimmy")
    customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
    invoice1 = create(:invoice, customer: customer1)
    invoice2 = create(:invoice, customer: customer1)
    item1 = create(:item, merchant: merchant1, name: "Toy")
    item2 = create(:item, merchant: merchant1, name: "Lightsaber")
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 15, unit_price: 100)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 10, unit_price: 500)
    bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 10, discount_percentage: 20)
    bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)
    bulk_discount3 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 40)
    bulk_discount4 = merchant1.bulk_discounts.create!(threshold: 20, discount_percentage: 30)
    bulk_discount5 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)

    expect(invoice_item1.discounted_revenue).to eq(900)
    expect(invoice_item2.discounted_revenue).to eq(5000)

  end
end
