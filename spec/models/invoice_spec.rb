require 'rails_helper'

RSpec.describe Invoice do

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, status: 0)}

  describe 'relations' do
    it { should belong_to :customer }
    it { should have_many :transactions}
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'instance methods' do
    describe '#creation_date_formatted' do
      it 'converts the invoice item invoice creation date to DAY, MM DD, YYYY' do
        expect(invoice_1.creation_date_formatted).to eq('Sunday, March 25, 2012')
      end
    end
  end
end
