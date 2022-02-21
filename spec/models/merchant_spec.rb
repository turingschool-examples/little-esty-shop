require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  it "exists" do
    merchant = create(:merchant)
    expect(merchant).to be_a(Merchant)
    expect(merchant).to be_valid
  end 

  it 'lists items ready to ship' do
    merchant = create(:merchant)
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    item4 = create(:item)
    invoice_item1 = (:invoice_item, result: 0, item_id: item1.id)
    invoice_item2 = (:invoice_item, result: 2, item_id: item2.id)

    expect(merchant.ordered_items_to_ship).to eq([item1, item1, item3, item8, item5])
  end
end
