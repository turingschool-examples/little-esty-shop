require "rails_helper"


RSpec.describe(InvoiceItem, type: :model) do
  let(:invoice_item) { InvoiceItem.new(    item_id: 539,     invoice_id: 1,     quantity: 12,     unit_price: 13635,     status: "pending") }

  describe 'relationships' do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end

  describe 'validations' do
    it {should validate_presence_of(:item_id)}
    it {should validate_presence_of(:invoice_id)}
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:status)}
    it {should validate_numericality_of(:item_id)}
    it {should validate_numericality_of(:invoice_id)}
    it {should validate_numericality_of(:quantity)}
    it {should validate_numericality_of(:unit_price)}
  end

  it("is an instance of invoice_item") do
    expect(invoice_item).to(be_instance_of(InvoiceItem))
  end

  it 'has an enum for status' do
    expect(invoice_item.status).to be_a(String)
    expect(invoice_item.status).to_not eq(nil)
  end

  describe 'class methods' do
    describe 'incomplete_invoices' do
      it 'returns invoice id for all invoices that have items that have not been shipped' do
        customer_1 = Customer.create!(first_name: 'Sandy', last_name: 'Busch')
        customer_2 = Customer.create!(first_name: 'Josh', last_name: 'Mann')
        customer_3 = Customer.create!(first_name: 'Miya', last_name: 'Yang')
        customer_4 = Customer.create!(first_name: 'Angel', last_name: 'Olsen')
        customer_5 = Customer.create!(first_name: 'Max', last_name: 'Smelter')

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 'completed')
        invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 'completed')
        invoice_3 = Invoice.create!(customer_id: customer_3.id, status: 'completed')
        invoice_4 = Invoice.create!(customer_id: customer_4.id, status: 'completed')
        invoice_5 = Invoice.create!(customer_id: customer_5.id, status: 'completed')

        merchant_1 = Merchant.create!(name: 'Schroder-Jerde')
        merchant_2 = Merchant.create!(name: 'Bradley and Sons')

        item_1 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_1.id)
        item_3 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_1.id)
        item_4 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_2.id)
        item_5 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: 75107, merchant_id: merchant_2.id)

        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')

        expect(InvoiceItem.incomplete_invoices).to eq([invoice_2.id,  invoice_4.id, invoice_5.id].sort)
      end
    end
  end
end
