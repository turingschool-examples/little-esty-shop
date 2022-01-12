require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validation' do
    it { should define_enum_for(:status).with([:packaged, :pending, :shipped]) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:invoice_id) }
  end

  describe 'relations' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Bella Donna')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 350)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 200)}
  let!(:item_3) {merchant_2.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000)}
  let!(:item_4) {merchant_2.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 150)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}

  let!(:invoice_item_1) {InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, item_id: item_1.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(quantity: 5, unit_price: item_2.unit_price, item_id: item_2.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(quantity: 1, unit_price: item_3.unit_price, item_id: item_3.id, invoice_id: invoice_1.id, status: 0)}

  describe 'class methods' do
    describe '::revenue' do
      it 'returns the revenue of an invoice' do
        expect(InvoiceItem.revenue).to eq(3050)
      end
    end
  end
end
