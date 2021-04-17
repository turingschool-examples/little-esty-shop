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
  end
end
