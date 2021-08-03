require 'rails_helper'

RSpec.describe InvoiceItem do
  before(:each) do
    @merchant_1 = create(:merchant)

    @customers = []
    @invoices = []
    @items = []
    @transactions = []
    @invoice_items = []

    5.times do
      @customers << create(:customer)
      @invoices << create(:invoice, customer_id: @customers.last.id, created_at: DateTime.new(2020,2,3,4,5,6))
      @items << create(:item, merchant_id: @merchant_1.id, unit_price: 20)
      @transactions << create(:transaction, invoice_id: @invoices.last.id)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1, quantity: 100, unit_price: @items.last.unit_price)
    end
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with([:pending, :packaged, :shipped]) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:quantity) }

  describe 'class methods' do
    describe '#total_revenue' do
      it 'can calculate the total revenue on an invoice' do
        expect(InvoiceItem.total_revenue).to eq(10000)
      end
    end
  end
end
end
