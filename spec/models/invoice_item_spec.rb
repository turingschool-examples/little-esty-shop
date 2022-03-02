require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do 
    it {should validate_presence_of :item_id}
    it {should validate_presence_of :invoice_id}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :status}
    it {should validate_presence_of :quantity}
  
    it {should validate_numericality_of :item_id}
    it {should validate_numericality_of :invoice_id}
    it {should validate_numericality_of :unit_price}
    it {should validate_numericality_of :quantity}
  end

  describe 'relationsships' do 
    it {should belong_to :invoice}
    it {should belong_to :item}
  end

  describe 'instance methods' do 
    describe 'change_status(result)' do
      it 'can change status of invoice item' do 
        invoice_item_1 = create(:invoice_item, status: "pending")
        expect(invoice_item_1.status).to eq("pending")
        invoice_item_1.change_status('packaged')
        expect(invoice_item_1.status).to eq("packaged")
      end
    end
  end
end
