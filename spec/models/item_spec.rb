require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
  it {should belong_to :merchant}
  it {should have_many :invoice_items}
  it {should have_many(:invoices).through(:invoice_items)}
  it {should validate_presence_of :name}
  it {should validate_presence_of :description}
  it {should validate_numericality_of :unit_price}
  end

  describe '#unit_price_to_dollars' do
    it 'converts unit price to dollars' do
      item1 = Item.find(1)
      item2 = Item.find(2)
      item3 = Item.find(3)

      expect(item1.unit_price_to_dollars).to eq(751.07)
      expect(item2.unit_price_to_dollars).to eq(670.76)
      expect(item3.unit_price_to_dollars).to eq(323.01)
    end
  end
end