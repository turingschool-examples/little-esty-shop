require 'rails_helper'

RSpec.describe Item do
  describe 'associations' do
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).only_integer }
  end

  describe 'instance methods' do
    describe '#enable_opposite' do
      it "returns the opposite of the item's enable/disable status; " do
        @merchant1 = Merchant.create!(name: 'Tom Holland')
        @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant1.id)

        expect(@item1.enable).to eq('enable')
        expect(@item1.enable_opposite).to eq('disable')
      end
    end
  end
end
