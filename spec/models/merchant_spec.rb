require 'rails_helper'
FactoryBot.find_definitions

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  before(:each) do
    @merchant = create(:merchant)

    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)

    @invoice1 = create(:invoice, customer: @customer1)
    @invoice2 = create(:invoice, customer: @customer2)
    @invoice3 = create(:invoice, customer: @customer3)
    @invoice4 = create(:invoice, customer: @customer4)
    @invoice5 = create(:invoice, customer: @customer5)
    @invoice6 = create(:invoice, customer: @customer6)

    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
    @item4 = create(:item, merchant: @merchant)
    @item5 = create(:item, merchant: @merchant)
    @item6 = create(:item, merchant: @merchant)

    create(:invoice_item, invoice: @invoice1, status:'packaged', item: @item1)
    create(:invoice_item, invoice: @invoice2, status:'packaged',item: @item2)
    create(:invoice_item, invoice: @invoice3, status:'packaged',item: @item3)
    create(:invoice_item, invoice: @invoice4, status:'pending', item: @item4)
    create(:invoice_item, invoice: @invoice5, status:'pending',item: @item5)
    create(:invoice_item, invoice: @invoice6, status:'shipped', item: @item6)

    create(:transaction, result: 'success', invoice: @invoice1)
    create(:transaction, result: 'success', invoice: @invoice1)
    create(:transaction, result: 'success', invoice: @invoice2)
    create(:transaction, result: 'success', invoice: @invoice2)
    create(:transaction, result: 'success', invoice: @invoice3)
    create(:transaction, result: 'success', invoice: @invoice3)
    create(:transaction, result: 'success', invoice: @invoice4)
    create(:transaction, result: 'success', invoice: @invoice4)
    create(:transaction, result: 'success', invoice: @invoice5)
    create(:transaction, result: 'success', invoice: @invoice5)
  end

  describe '#top_customers' do
    it 'returns the top 5 customers for the given merchant' do
      expect(@merchant.top_customers).to eq([@customer1, @customer2, @customer3, @customer4, @customer5])
    end
  end

  describe '#shippable_items' do
    it 'returns the items that are ready to ship in order from oldest to newest' do

      expect(@merchant.shippable_items.length).to eq(3)
      expect(@merchant.shippable_items).to eq([@item1, @item2, @item3])
      expect(@merchant.shippable_items.first.invoice_created_at).to be < @merchant.shippable_items.last.invoice_created_at
    end
  end

  describe '#invoices' do
    it "returns all invoices related to that merchant's items" do
      expect(@merchant.invoice_ids).to include(@invoice1.id, @invoice2.id, @invoice3.id)
    end
  end
end
