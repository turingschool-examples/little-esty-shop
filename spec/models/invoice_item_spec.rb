require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it {should belong_to :item}
    it {should belong_to :invoice}
  end

  describe 'validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
    it {should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0)}
    it {should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)}
  end

  it 'status can be pending' do
     invoice_item = create(:invoice_item, status: :pending)
     expect(invoice_item.status).to eq("pending")
     expect(invoice_item.pending?).to eq(true)
     expect(invoice_item.packaged?).to eq(false)
     expect(invoice_item.shipped?).to eq(false)
   end

   it 'status can be packaged' do
      invoice_item = create(:invoice_item, status: :packaged)
      expect(invoice_item.status).to eq("packaged")
      expect(invoice_item.pending?).to eq(false)
      expect(invoice_item.packaged?).to eq(true)
      expect(invoice_item.shipped?).to eq(false)
    end

    it 'status can be shipped' do
       invoice_item = create(:invoice_item, status: :shipped)
       expect(invoice_item.status).to eq("shipped")
       expect(invoice_item.pending?).to eq(false)
       expect(invoice_item.packaged?).to eq(false)
       expect(invoice_item.shipped?).to eq(true)
     end
     
end
