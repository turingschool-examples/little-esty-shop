require 'rails_helper'

RSpec.describe Merchant do
  describe 'associations' do
    it {should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'Methods' do 
    before :each do 
      @merchant = Merchant.create!(name: 'Tom Holland')
      
      @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant.id)
      @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant.id)
      @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant.id)
    end 
    describe '::merchant_items' do 
      it 'returns all of the merchants items' do 
        expect(@merchant.merchant_items).to eq([@item1, @item2, @item3])
      end 
    end
  end 

end
