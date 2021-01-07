require "rails_helper"

describe Item, type: :model do
  describe "relations" do
    it {should have_many :invoice_items}
    it {should have_many :invoices}
    it {should belong_to :merchant}
  end

  describe 'class methods' do
    it 'items_to_ship;' do
      merchant1 = create(:merchant)
      items = create_list(:item, 6, merchant: merchant1)
      items.first(4).each do |item|
        create(:invoice_item, item: item, status: 1)
      end

      expect(Item.items_to_ship.to_set).to eq(items.first(4).to_set)
    end
  end
end
