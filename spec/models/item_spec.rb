require 'rails_helper'

RSpec.describe Item, type: :model do 
  describe 'relationships' do 
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) } 
  end 

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  it 'converts unit price to dollars' do 
    merchant_1 = Merchant.create(name: "Ray's Handmade Jewelry")
    item_1 = merchant_1.items.create!(name: "Dangly Earings" , description: 'They tickle your neck.', unit_price: 1500 )
    
    expect(item_1.unit_price_to_dollars).to eq('15.00')
  end
end