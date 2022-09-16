require "rails_helper"


RSpec.describe(Invoice, type: :model) do
  let(:invoice) { Invoice.new(    customer_id: 1,     status: "in progress") }

  describe("relationships") do
    it { should(have_many(:transactions)) }
    it { should(belong_to(:customer)) }
    it { should(have_many(:invoice_items)) }
    it { should(have_many(:items).through(:invoice_items)) }
    it { should(validate_numericality_of(:customer_id)) }
  end

  describe("validations") do
    it { should(validate_presence_of(:customer_id)) }
    it { should(validate_presence_of(:status)) }
  end

  it("is an instance of invoice") do
    expect(invoice).to(be_instance_of(Invoice))
  end

  describe("relationships") do
    it { should(have_many(:transactions)) }
  end

  describe 'class methods' do
    describe 'incomplete_invoices' do
      it 'returns invoice id for all invoices that have items that have not been shipped' do
        5.times do
          Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
        end

        invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed', created_at: Time.now)
        invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed', created_at: Time.now - 2.days)
        invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed', created_at: Time.now - 1.days)
        invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed', created_at: Time.now - 3.days)
        invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed', created_at: Time.now - 4.days)

        merchant_1 = Merchant.create!(name: 'Schroder-Jerde')
        merchant_2 = Merchant.create!(name: 'Bradley and Sons')

        item_1 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 5), merchant_id: merchant_1.id)
        item_2 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 5), merchant_id: merchant_1.id)
        item_3 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 4), merchant_id: merchant_1.id)
        item_4 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 5), merchant_id: merchant_2.id)
        item_5 = Item.create!(name: 'Item Qui Esse', description: 'Nihil autem sit odio', unit_price: Faker::Number.number(digits: 4), merchant_id: merchant_2.id)

        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')

        expect(Invoice.incomplete_invoices).to eq([invoice_5, invoice_4, invoice_2])
      end
    end
  end
end
