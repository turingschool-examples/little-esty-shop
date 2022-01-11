require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to :customer }
  end

  describe "validations" do
    it { should validate_presence_of(:customer) }
  end

  describe 'instance methods' do
    before(:each) do
      @customer = FactoryBot.create(:customer, first_name: "Cookie", last_name: "Monster")
      @invoice = FactoryBot.create(:invoice, customer: @customer, created_at: Date.today)
      @invoice2 = FactoryBot.create(:invoice)
      @item = FactoryBot.create(:item, status: "enabled")
      @item2 = FactoryBot.create(:item)
      @invoiceitem = FactoryBot.create(:invoice_item, invoice: @invoice, item: @item, status: "pending", quantity: 5, unit_price: 1000)
      @invoiceitem2 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 10, unit_price: 2000)
    end

    describe 'pretty_created_at' do
      it 'formats created_at datetime' do
        expect(@invoice.pretty_created_at).to eq(Date.today.strftime("%A, %B %-d, %Y"))
      end
    end

    describe 'customer_name' do
      it 'outputs customer full name' do
        expect(@invoice.customer_name).to eq("Cookie Monster")
      end
    end

    describe 'items_info' do
      it 'shows invoice items with order info' do
        first = @invoice.items_info.first
        expect(first.name).to eq(@item.name)
        expect(first.quantity).to eq(@invoiceitem.quantity)
        expect(first.status).to eq(@invoiceitem.status)
        expect(first.unit_price).to eq(@invoiceitem.unit_price)
      end
    end

    describe 'total_revenue' do
      it 'calculates total revenue for invoice' do
        expect(@invoice.total_revenue).to eq(25000)
      end
    end


  end

  describe '::incomplete' do
    let!(:invoice_6) {FactoryBot.create(:invoice, created_at: "Sun, 9 Jan 2022 06:10:00 UTC +00:00")}
    let!(:invoice_7) {FactoryBot.create(:invoice, created_at: "Mon, 10 Jan 2022 06:15:00 UTC +00:00")}

    let!(:invoice_item_1) {FactoryBot.create(:invoice_item, invoice: invoice_6, status: "pending")}
    let!(:invoice_item_2) {FactoryBot.create(:invoice_item, invoice: invoice_7, status: "packaged")}
    let!(:invoice_item_3) {FactoryBot.create(:invoice_item, status: "shipped")}
    let!(:invoice_item_4) {FactoryBot.create(:invoice_item, status: "shipped")}

    it 'returns all of the invoices which havent yet shipped, in order from oldest to newest' do
      expect(Invoice.incomplete).to include(invoice_item_1.invoice)
      expect(Invoice.incomplete).to include(invoice_item_2.invoice)
    end

    it 'is ordered from oldest to newest' do
      expect(Invoice.incomplete).to eq([invoice_item_1.invoice, invoice_item_2.invoice])
    end
  end
end
