require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:item_status) }
    it { should validate_numericality_of(:item_status) }
  end

  describe 'relationships' do
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
  end


  describe 'display price method' do
    it 'will display dollars in cents' do
      merchant_1 = Merchant.create!(name: "Ana Maria")
      merchant_2 = Merchant.create!(name: "Juan Lopez")
      item_1 = merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2475)
      item_2 = merchant_2.items.create!(name: "onion", description: "red onion", unit_price: 3450)

      expect(item_2.display_price).to eq("34.50")
      expect(item_1.display_price).to eq("24.75")

    end
  end
end
