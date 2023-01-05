require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
  it {should belong_to :merchant}
  it {should have_many :invoice_items}
  it {should have_many(:invoices).through(:invoice_items)}
  it {should validate_presence_of :name}
  it {should validate_presence_of :unit_price}
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

  describe '#dollars_to_unit_price' do
    it 'converts dollars to unit_price' do
      expect(Item.dollars_to_unit_price(100.99)).to eq(10099)
      expect(Item.dollars_to_unit_price(0)).to eq(0)
      expect(Item.dollars_to_unit_price("99.99")).to eq(9999)
    end
  end

  describe '#switch_enabled_field' do
    it 'changes an items enabled field from true to false or vice versa' do
      item = Item.find(10)
      expect(item.enabled).to eq(true)

      item.switch_enabled_field

      expect(item.enabled).to eq(false)

      item.switch_enabled_field
      
      expect(item.enabled).to eq(true)
    end
  end
end