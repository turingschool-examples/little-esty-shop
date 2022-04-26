require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
    it {
      should define_enum_for(:status).with([
        'Pending', 'Packaged', 'Shipped'
      ])
    }
  end

  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  it 'Finds highest applicable discount for an invoice item' do
    merchant = create :merchant
    customer = create :customer
    invoice = create :invoice, {customer: customer}
    item = create :item, {unit_price: 10, merchant: merchant}
    invoice_item = create :invoice_item, {item: item, invoice: invoice, quantity: 4}
    bulk_discount1 = create :bulk_discount, {quantity_threshold: 3, percentage_discount: 10, merchant: merchant}
    bulk_discount2 = create :bulk_discount, {quantity_threshold: 5, percentage_discount: 20, merchant: merchant}

    expected = bulk_discount1
    expect(invoice_item.discount).to eq(expected)
  end

  it 'Returns discount percentage for an invoice item if any discounts are applicable' do
    merchant = create :merchant
    customer = create :customer
    invoice = create :invoice, {customer: customer}
    item = create :item, {unit_price: 10, merchant: merchant}
    invoice_item = create :invoice_item, {item: item, invoice: invoice, quantity: 4}
    bulk_discount1 = create :bulk_discount, {quantity_threshold: 3, percentage_discount: 10, merchant: merchant}
    bulk_discount2 = create :bulk_discount, {quantity_threshold: 5, percentage_discount: 20, merchant: merchant}

    expected = BigDecimal("1.00") - bulk_discount1[:percentage_discount] * BigDecimal("0.01")

    actual = invoice_item.bulk_discount

    expect(actual).to eq(expected.to_f)
  end
end
