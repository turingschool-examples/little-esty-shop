require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  before(:each) do
    @disabled_item_1 = create(:item)
    @disabled_item_2 = create(:item)
    @enabled_item_1  = create(:item, status: 'Enabled')
    @enabled_item_2  = create(:item, status: 'Enabled')
  end

  describe '.class methods' do
    describe '.enabled' do
      it 'returns all enabled items' do
        expect(Item.enabled).to eq([@enabled_item_1, @enabled_item_2])
      end
    end

    describe '.disabled' do
      it 'returns all disabled items' do
        expect(Item.disabled).to eq([@disabled_item_1, @disabled_item_2])
      end
    end
  end

  describe '#instance methods' do
    describe '#update_status!(enable, disable)' do
      it 'updates the status to Enabled or Disabled' do
        expect(@disabled_item_1.status).to eq("Disabled")
        @disabled_item_1.update_status!(true, nil)
        expect(@disabled_item_1.status).to eq("Enabled")

        expect(@enabled_item_1.status).to eq("Enabled")
        @enabled_item_1.update_status!(nil, true)
        expect(@enabled_item_1.status).to eq("Disabled")
      end
    end
  end
end

# describe '#enabled?' do
#   it 'confirms if enabled is true' do
#     expect(@disabled_item_1.disabled?).to eq(true)
#     expect(@enabled_item_1.disabled?).to eq(false)
#   end
# end
