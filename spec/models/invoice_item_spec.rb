require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it {should belong_to :invoice}
  it {should belong_to :item}

  it {should validate_presence_of :item_id}
  it {should validate_presence_of :invoice_id}
  it {should validate_presence_of :unit_price}
  it {should validate_presence_of :status}
  it {should validate_presence_of :quantity}

  it {should validate_numericality_of :item_id}
  it {should validate_numericality_of :invoice_id}
  it {should validate_numericality_of :unit_price}
  it {should validate_numericality_of :quantity}
  
  describe 'instance methods' do
    it 'can change the status of an invoice_item' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      invoice_1 = create(:invoice)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, status: "pending")

      merchant_2 = create(:merchant)
      item_2 = create(:item, merchant_id: merchant_2.id)
      invoice_2 = create(:invoice)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: "packaged")

      invoice_item_1.change_status("packaged")
      expect(invoice_item_1.status).to eq("packaged")
      expect(invoice_item_1.status).to_not eq("pending")

      invoice_item_2.change_status("shipped")
      expect(invoice_item_2.status).to eq("shipped")
      expect(invoice_item_2.status).to_not eq("packaged")
    end
  end
end
