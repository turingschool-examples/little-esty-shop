require "rails_helper"


RSpec.describe(InvoiceItem, type: :model) do
  let(:invoice_item) { InvoiceItem.new(    item_id: 539,     invoice_id: 1,     quantity: 12,     unit_price: 13635,     status: "pending") }

  describe("relationships") do
    it { should(belong_to(:invoice)) }
    it { should(belong_to(:item)) }
  end

  describe("validations") do
    it { should(validate_presence_of(:item_id)) }
    it { should(validate_presence_of(:invoice_id)) }
    it { should(validate_presence_of(:quantity)) }
    it { should(validate_presence_of(:unit_price)) }
    it { should(validate_presence_of(:status)) }
    it { should(validate_numericality_of(:item_id)) }
    it { should(validate_numericality_of(:invoice_id)) }
    it { should(validate_numericality_of(:quantity)) }
    it { should(validate_numericality_of(:unit_price)) }
  end

  it("is an instance of invoice_item") do
    expect(invoice_item).to(be_instance_of(InvoiceItem))
  end

  it("has an enum for status") do
    expect(invoice_item.status).to(be_a(String))
    expect(invoice_item.status).to_not(eq(nil))
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
        expect(InvoiceItem.incomplete_invoices.sort).to eq([invoice_2.id,  invoice_4.id, invoice_5.id])
      end
    end
  end
end
