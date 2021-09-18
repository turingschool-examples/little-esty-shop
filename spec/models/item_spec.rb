require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items).dependent(:destroy) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  before(:each) do
    @disabled_item = create(:item)
    @enabled_item  = create(:item, status: 'Enabled')
  end

  describe '#instance methods' do
    describe '#enabled?' do
      it 'confirms if enabled is true' do
        expect(@disabled_item.disabled?).to eq(true)
        expect(@enabled_item.disabled?).to eq(false)
      end
    end

    describe '#update_status!(enable, disable)' do
      it 'updates the status to Enabled or Disabled' do
        expect(@disabled_item.status).to eq("Disabled")
        @disabled_item.update_status!(true, nil)
        expect(@disabled_item.status).to eq("Enabled")

        expect(@enabled_item.status).to eq("Enabled")
        @enabled_item.update_status!(nil, true)
        expect(@enabled_item.status).to eq("Disabled")
      end
    end
  end
end
