require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }

    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }

    it { should have_many :transactions }
  end

  describe 'methods' do
    it "can return incomplete invoices" do
      time1 = Time.new(2008,6,21, 13,30,0, "+09:00").utc
      time2 = Time.new(2006,6,21, 13,30,0, "+09:00").utc
      time3 = Time.new(2015,6,21, 13,30,0, "+09:00").utc

      invoice1 = create(:invoice, created_at: time1)
      invoice2 = create(:invoice, created_at: time2)
      invoice3 = create(:invoice, created_at: time3)

      item1 = create(:item)
      item2 = create(:item)

      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, status: 0)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item1, status: 1)
      invoice_item3 = create(:invoice_item, invoice: invoice3, item: item2, status: 2)

      expect(Invoice.incomplete_invoices).to eq([invoice2, invoice1])
    end

    it "can format date correctly" do
      time = Time.new(2008,6,21, 13,30,0, "+09:00").utc

      invoice1 = create(:invoice, created_at: time)

      expect(invoice1.format_time).to eq("Saturday, June 21, 2008")
    end
  end
end