require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:invoice_item){ create :invoice_item}
  let(:status){['pending','packaged','shipped']}

  it 'tests relationships' do
    expect(invoice_item).to respond_to(:item)
    expect(invoice_item).to respond_to(:invoice)
  end

  describe 'enum' do
    it 'has the right index' do
      status.each_with_index do |item, index|
        expect(InvoiceItem.statuses[item]).to eq(index)
      end
    end
  end
end
