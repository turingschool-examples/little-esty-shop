require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'Relationships' do
    it {should belong_to :invoice}
    it {should belong_to :item}
    it {should have_many(:transactions).through(:invoice)}
    it {should validate_numericality_of :quantity}
    it {should validate_numericality_of :unit_price}
  end

  it 'converts unit price to dollars' do
    expect(InvoiceItem.first.unit_price_to_dollars).to eq("$136.35")
  end
end