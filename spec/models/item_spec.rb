require "rails_helper"

describe Item, type: :model do
  describe "relations" do
    it {should have_many :invoice_items}
    it {should have_many :invoices}
    it {should belong_to :merchant}
  end

  describe 'class methods:' do
    it 'items_to_ship;' do
      merchant1 = create(:merchant)
      items = create_list(:item, 6, merchant: merchant1)
      items.first(4).each do |item|
        create(:invoice_item, item: item, status: 1)
      end

      expect(Item.items_to_ship.to_set).to eq(items.first(4).to_set)
    end
    it 'popular_items' do
      merchant1 = create(:merchant)
      item = create(:item, merchant: merchant1)
      items = create_list(:item, 5, merchant: merchant1, unit_price: 1)
      
      items.each_with_index do |item, index|
        (1 + index).times do
          invoice = create(:invoice, items: [item])
          create(:transaction, invoice_id: invoice.id, result: 0)
        end
      end

      expect(Item.popular_items.to_set).to eq(items.to_set)
    end
  end
end
