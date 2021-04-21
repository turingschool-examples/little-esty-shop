require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }

    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }

    it { should validate_presence_of(:name) }
  end

  describe 'model methods' do
    it 'can show only enabled items' do
      item1 = create(:item, enabled: true)
      item2 = create(:item, enabled: false)

      expect(Item.enable).to eq([item1])
    end

    it 'can show only disabled items' do
      item1 = create(:item, enabled: true)
      item2 = create(:item, enabled: false)
      item3 = create(:item, enabled: false)

      expect(Item.disable).to eq([item2, item3])
    end

    it 'finds the date of highest revenue for item' do
      time1 = Time.new(2008,6,21, 13,30,0, "+09:00").utc
      time2 = Time.new(2006,6,21, 13,30,0, "+09:00").utc
      time3 = Time.new(2015,6,21, 13,30,0, "+09:00").utc

      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)

      invoice1 = create(:invoice, created_at: time1)
      invoice2 = create(:invoice, created_at: time2)
      invoice3 = create(:invoice, created_at: time3)

      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 1, unit_price: 300)
      invoice_item2 = create(:invoice_item, item: item1, invoice: invoice2, quantity: 2, unit_price: 100)
      invoice_item3 = create(:invoice_item, item: item2, invoice: invoice2, quantity: 3, unit_price: 200)
      invoice_item4 = create(:invoice_item, item: item1, invoice: invoice3, quantity: 4, unit_price: 400)
      invoice_item5 = create(:invoice_item, item: item2, invoice: invoice3, quantity: 5, unit_price: 50)
      invoice_item6 = create(:invoice_item, item: item3, invoice: invoice3, quantity: 6, unit_price: 500)

      expect(item1.best_day).to eq(invoice3.format_time)
      expect(item2.best_day).to eq(invoice2.format_time)
      expect(item3.best_day).to eq(invoice3.format_time)
    end
  end
end
