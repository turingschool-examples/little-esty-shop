require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'relationships' do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  describe 'class methods' do
    it '#invoice_finder' do
      merchant1 = create(:merchant)
      invoice1 = create(:invoice)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      expect(Item.invoice_finder(item1.merchant_id)).to eq [invoice1]
    end

    it '#enabled_items' do
      merchant = create(:merchant)
      item1 = create(:item, merchant: merchant, name: "Paul")
      item2 = create(:item, merchant: merchant, name: "Leland")
      item3 = create(:item, merchant: merchant, name: "Josh", status: 1)
      item4 = create(:item, merchant: merchant, name: "My mom", status: 1)

      expect(Item.enabled_items).to eq([item3, item4])
    end

    it '#disabled_items' do
      merchant = create(:merchant)
      item1 = create(:item, merchant: merchant, name: "Paul")
      item2 = create(:item, merchant: merchant, name: "Leland")
      item3 = create(:item, merchant: merchant, name: "Josh", status: 1)
      item4 = create(:item, merchant: merchant, name: "My mom", status: 1)

      expect(merchant.items.disabled_items).to eq([item1, item2])
    end
  end

  describe "instance methods" do
    describe 'potential_revenue' do
      it "returns the potential_revenue associated with that item. Only counts invoices that have valid transactions." do
        item_1 = create(:item_with_transactions, name: 'Toy', invoice_item_quantity: 3, invoice_item_unit_price: 15000, transaction_result: 1)
        expect(item_1.potential_revenue).to eq(0)

        item_2 = create(:item_with_transactions, name: 'Car', invoice_item_quantity: 5, invoice_item_unit_price: 20000, transaction_result: 0)
        expect(item_2.potential_revenue).to eq(100000)

        item_3 = create(:item_with_transactions, name: 'Desk', invoice_item_quantity: 2, invoice_item_unit_price: 20000, transaction_result: 0)
        item_3.item_invoices.update(item: item_2)
        expect(item_2.potential_revenue).to eq(140000)

      end
    end
  end
end
