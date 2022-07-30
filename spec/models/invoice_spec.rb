require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  before :each do

  end

  describe 'class methods' do
    it 'incomplete_invoices lists all invoices with items that have not shipped' do
      merchant = Merchant.create!(name: 'Mike Dao')
      customer = Customer.create!(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.unique.last_name)
      8.times do
          Item.create!(name: Faker::Beer.name, description: Faker::Beer.style, unit_price: Faker::Number.digit, merchant_id: merchant.id )
      end
      10.times do
          invoice = Invoice.create!(status: Faker::Number.between(from: 0, to: 2), customer_id: customer.id)
          InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'pending', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))
          InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'pending', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))
      end
      invoice = Invoice.create!(status: Faker::Number.between(from: 0, to: 2), customer_id: customer.id)
      InvoiceItem.create!(invoice_id: invoice.id,quantity: Faker::Number.digit, unit_price: Faker::Number.digit, status: 'shipped', item_id: Faker::Number.between(from: Item.first.id, to: Item.last.id))

      expect(Invoice.incomplete_invoices.all.count).to eq(10)
      expect(Invoice.incomplete_invoices.all).to_not includes(invoice)
    end
  end

  describe 'instance methods' do

  end
end
