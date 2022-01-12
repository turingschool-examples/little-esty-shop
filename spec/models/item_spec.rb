require 'rails_helper'

RSpec.describe Item do
  describe 'relations' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values([:enabled, :disabled]) }
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_presence_of(:merchant_id)}
  end

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Swan Ronson')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100, status: 0)}
  let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "A thing around your neck", unit_price: 100, status: 1)}
  let!(:item_4) {merchant_2.items.create!(name: "Earrings", description: "A thing around your neck", unit_price: 100, status: 1)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2) {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_3) {customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')}
  let!(:invoice_5) {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_6) {customer_1.invoices.create!(status: 1, created_at: '2012-03-29 12:54:09')}
  let!(:invoice_7) {customer_1.invoices.create!(status: 1, created_at: '2012-05-28 12:54:09')}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1000, quantity: 3, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, unit_price: 1000, quantity: 4, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, unit_price: 1000, quantity: 1, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, unit_price: 1000, quantity: 9, status: 0)}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_1.unit_price, quantity: 2, status: 0)}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_6.id, unit_price: item_2.unit_price, quantity: 4, status: 0)}
  let!(:invoice_item_7) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_6.id, unit_price: item_3.unit_price, quantity: 1, status: 0)}
  let!(:invoice_item_8) {InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_6.id, unit_price: item_4.unit_price, quantity: 5, status: 0)}

  describe '#class_methods' do
    describe "::disabled_items" do
      it 'returns disabled items' do
        expect(Item.disabled_items).to eq([item_3, item_4])
      end
    end

    describe "::enabled_items" do
      it 'returns enabled items' do
        expect(Item.enabled_items).to eq([item_1, item_2])
      end
    end
  end

  describe 'instance methods' do
    describe '#date_with_most_sales' do
      it 'shows date that the item sold the most' do
        expect(item_1.date_with_most_sales).to eq("03/28/2012")
      end

      it 'returns most recent date if multiple days have equal top sales' do
        invoice_item_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, unit_price: 1000, quantity: 9, status: 0)
        expect(item_1.date_with_most_sales).to eq("05/28/2012")
      end
    end

    describe '#invoice_items_filtered_by_ivoice_id' do
      it 'returns all invoice_items for an item that are associated with a specific invoice_id' do
        expect(item_1.invoice_items_filtered_by_ivoice_id(invoice_3.id)).to eq([invoice_item_3])
      end

      it 'returns multiple invoice items if it has been added to an invoice multiple times' do
        expect(item_1.invoice_items_filtered_by_ivoice_id(invoice_6.id)).to eq([invoice_item_5, invoice_item_6])
      end
    end
  end
end
