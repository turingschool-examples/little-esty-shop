require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should validate_presence_of(:quantity)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_presence_of(:status)}
  end

  describe 'enums' do
    it do
      should define_enum_for(:status).
     with_values(["pending", "shipped", "packaged"])
    end
  end

  describe 'instance methods' do
    before :each do
      test_data
    end
    
    describe 'item_name' do
      it 'returns the name of the item
        associated with the invoice_item' do
        expect(@invoice_item_19.item_name).to eq("Shrooms")
      end
    end
  end
end
