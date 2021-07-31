require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should define_enum_for(:status).with_values([:enabled, :disabled])}
  end

  describe 'instance methods' do
    it 'can transform unit price to dollars' do
      merchant1 = Merchant.create!(name: 'Sparkys Shop')
      item = merchant1.items.create!(name: 'Teddy Bear', description: 'So fuzzy', unit_price: 2050)

      expect(item.price_to_dollars).to eq(20.50)
    end
  end
end
