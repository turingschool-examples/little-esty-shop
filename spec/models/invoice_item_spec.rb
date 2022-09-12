require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let(:invoice_item) { InvoiceItem.new(item_id: 539,
    invoice_id: 1,
    quantity: 12,
    unit_price: 13635,
    status: 'pending') }

  it 'is an instance of customer' do
    expect(invoice_item).to be_instance_of(InvoiceItem)
  end
end