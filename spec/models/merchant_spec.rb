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
  let!(:invoice_item1) { create(:invoice_item, item: @items[0], invoice: @invoices[0]) }
  let!(:invoice_item2) { create(:invoice_item, item: @items[1], invoice: @invoices[1]) }
  let!(:invoice_item3) { create(:invoice_item, item: @items[0], invoice: @invoices[2]) }
  let!(:invoice_item4) { create(:invoice_item, item: @items[1], invoice: @invoices[3]) }
  let!(:invoice_item5) { create(:invoice_item, item: @items[0], invoice: @invoices[4]) }
  let!(:invoice_item6) { create(:invoice_item, item: @items[1], invoice: @invoices[5]) }
  let!(:invoice_item7) { create(:invoice_item, item: @items[0], invoice: @invoices[6]) }
  let!(:invoice_item8) { create(:invoice_item, item: @items[1], invoice: @invoices[7]) }
  let!(:invoice_item9) { create(:invoice_item, item: @items[0], invoice: @invoices[8]) }
  let!(:invoice_item10) { create(:invoice_item, item: @items[1], invoice: @invoices[9]) }
  let!(:invoice_item11) { create(:invoice_item, item: @items[0], invoice: @invoices[10]) }
  let!(:invoice_item12) { create(:invoice_item, item: @items[1], invoice: @invoices[11]) }


  describe '#instance methods' do
    it 'returns top 5 customers' do
      expect(merchants[0].top_5_customers).to eq(customers[1..5])

    end
  end
end
