require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'valdiations' do
    it { should validate_presence_of :name}
    it {should define_enum_for(:status).with_values(["disabled", "enabled"])}
  end

  let!(:merchants) { create_list(:merchant, 2) }
  let!(:customers) { create_list(:customer, 6) }

  before :each do
    @items = merchants.flat_map do |merchant|
      create_list(:item, 2, merchant: merchant)
    end

    @invoices = customers.flat_map do |customer|
      create_list(:invoice, 2, customer: customer)
    end

    @transactions = @invoices.each_with_index.flat_map do |invoice, index|
      if index < 2
        create_list(:transaction, 2, invoice: invoice, result: 1)
      else
        create_list(:transaction, 2, invoice: invoice, result: 0)
      end
    end
  end
  let!(:invoice_item1) { create(:invoice_item, item: @items[0], invoice: @invoices[0], status: 0) }
  let!(:invoice_item2) { create(:invoice_item, item: @items[1], invoice: @invoices[1], status: 1) }
  let!(:invoice_item3) { create(:invoice_item, item: @items[0], invoice: @invoices[2], status: 1) }
  let!(:invoice_item4) { create(:invoice_item, item: @items[1], invoice: @invoices[3], status: 0) }
  let!(:invoice_item5) { create(:invoice_item, item: @items[0], invoice: @invoices[4], status: 0) }
  let!(:invoice_item6) { create(:invoice_item, item: @items[1], invoice: @invoices[5], status: 1) }
  let!(:invoice_item7) { create(:invoice_item, item: @items[0], invoice: @invoices[6], status: 1) }
  let!(:invoice_item8) { create(:invoice_item, item: @items[1], invoice: @invoices[7], status: 1) }
  let!(:invoice_item9) { create(:invoice_item, item: @items[0], invoice: @invoices[8], status: 1) }
  let!(:invoice_item10) { create(:invoice_item, item: @items[1], invoice: @invoices[9], status: 0) }
  let!(:invoice_item11) { create(:invoice_item, item: @items[0], invoice: @invoices[10], status: 2) }
  let!(:invoice_item12) { create(:invoice_item, item: @items[1], invoice: @invoices[11], status: 2) }

  describe ".class methods" do
    let!(:merchant1) { create(:merchant, status: 0) }
    let!(:merchant2) { create(:merchant, status: 1) }
    let!(:merchant3) { create(:merchant, status: 0) }
    let!(:merchant4) { create(:merchant, status: 1) }

    it ".enabled returns only merchants with an enabled status" do
      # enums method
      expect(Merchant.enabled).to include(merchant2)
      expect(Merchant.enabled).to include(merchant4)
      expect(Merchant.enabled).to_not include(merchant1)
      expect(Merchant.enabled).to_not include(merchant3)
    end

    it ".disabled returns only merchants with a disabled status" do
      # enums method
      expect(Merchant.disabled).to include(merchant1)
      expect(Merchant.disabled).to include(merchant3)
      expect(Merchant.disabled).to_not include(merchant2)
      expect(Merchant.disabled).to_not include(merchant4)
    end
  end

  describe '#instance methods' do
    it 'returns top 5 customers' do
      # this fails like once out of every 20 tests...
      # I think it might be because if the transaction count is the same...
      # it doesn't have an explicit order...should we also order by name? how would we test for that?
      expect(merchants[0].top_5_customers).to eq(customers[1..5])
    end

    it 'returns item names ordered, not shipped' do
      expect(merchants[0].ordered_not_shipped).to eq([
        invoice_item1,
        invoice_item2,
        invoice_item3,
        invoice_item4,
        invoice_item5,
        invoice_item6,
        invoice_item7,
        invoice_item8,
        invoice_item9,
        invoice_item10
        ])#item and item invoice number
    end
  end
end
