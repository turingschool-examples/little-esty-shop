require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe "::class methods" do
    let!(:merchant1) { create(:merchant)}
    let!(:merchant2) { create(:merchant)}

    let!(:item1) {create(:item, merchant: merchant1)}  
    let!(:item2) {create(:item, merchant: merchant1, status: 'enabled')}
    let!(:item3) {create(:item, merchant: merchant1)}
    let!(:item4) {create(:item, merchant: merchant1)}
    let!(:item5) {create(:item, merchant: merchant2)}

    it "::enabled_items" do
      expect(merchant1.items.enabled_items).to eq([item2])

      item3.update(status: 0)
      expect(merchant1.items.enabled_items).to eq([item2, item3])
    end

    it "::disabled_items" do
      expect(merchant1.items.disabled_items).to eq([item1, item3, item4])

      item2.update(status: 1)
      expect(merchant1.items.disabled_items).to eq([item1, item3, item4, item2])
    end
  end
end
