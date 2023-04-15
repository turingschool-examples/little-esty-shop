require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  
  describe 'relationships' do
    it { should belong_to :invoice}
    it { should belong_to :item}
  end

  before(:each) do
    test_data
  end

  describe 'class methods' do
    it '::not_yet_shipped' do 
      expect(@merchant_1.invoice_items.not_yet_shipped.count).to eq(26)

      @invoice_item_25.update!(status: 2)
      @invoice_item_26.update!(status: 2)

      expect(@merchant_1.invoice_items.not_yet_shipped.count).to eq(24)
    end
  end

  describe 'instance methods' do
    it '#item_name' do
      expect(@invoice_item_1.item_name).to eq(@item_1.name)
    end
  end
end

