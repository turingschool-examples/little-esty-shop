require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer)}
    it { should have_many(:invoice_items)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions)}
  end

  describe 'enum validation' do
    it { should define_enum_for(:status).with([:in_progress, :cancelled, :completed])}
  end

  describe 'instant methods' do
    describe '#customer_name' do
      it 'displays a customers first and last name' do
        merchant1 = create(:merchant)
        invoice1 = create(:invoice)
        item1 = create(:item, merchant: merchant1)
        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)

        expect(invoice1.customer_name).to eq("Default First Name 1 Default Last Name 1")
      end
    end
  end
end
