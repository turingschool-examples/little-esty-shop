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
          create(:random_customer)
        end

        invoice_1 = create(:random_invoice, customer: Customer.all[0])
        invoice_2 = create(:random_invoice, customer: Customer.all[1])
        invoice_3 = create(:random_invoice, customer: Customer.all[2])
        invoice_4 = create(:random_invoice, customer: Customer.all[3])
        invoice_5 = create(:random_invoice, customer: Customer.all[4])

        merchant_1 = create(:random_merchant)
        merchant_2 = create(:random_merchant)

        item_1 = create(:random_item, merchant_id: merchant_1.id)
        item_2 = create(:random_item, merchant_id: merchant_1.id)
        item_3 = create(:random_item, merchant_id: merchant_1.id)
        item_4 = create(:random_item, merchant_id: merchant_2.id)
        item_5 = create(:random_item, merchant_id: merchant_2.id)

        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3635, status: 'shipped')
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 31, unit_price: 13635, status: 'packaged')
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 13, unit_price: 1335, status: 'shipped')
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 30, unit_price: 1335, status: 'pending')
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 12, unit_price: 1365, status: 'packaged')

        expect(Invoice.incomplete_invoices).to eq([invoice_2, invoice_4, invoice_5 ])
      end
    end
  end

  describe 'class methods' do
    describe 'total_revenue' do
      it 'calculates the total revenue for each invoice' do
        customer_1 = create(:random_customer)

        invoice_1 = create(:random_invoice, customer: Customer.all[0])
        invoice_2 = create(:random_invoice, customer: Customer.all[0])

        merchant_1 = create(:random_merchant)

        item_1 = create(:random_item, merchant_id: merchant_1.id)
        item_2 = create(:random_item, merchant_id: merchant_1.id)
        item_3 = create(:random_item, merchant_id: merchant_1.id)

        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 4999, status: 'shipped')
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2001, status: 'shipped')
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_1.id, quantity: 4, unit_price: 4575, status: 'shipped')

        expect(invoice_1.total_revenue).to eq(30299)
        expect(invoice_2.total_revenue).to eq(0)
      end
    end
  end
end
