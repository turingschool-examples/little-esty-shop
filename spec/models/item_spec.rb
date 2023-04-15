require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:unit_price) }

  before :each do
    test_data
  end

  describe 'enums' do
    it do
      should define_enum_for(:status).
      with_values(["enabled", "disabled"])
    end
  end

  describe 'instance methods' do
    it '#unit_price_to_dollars' do
      expect(@item_1.unit_price).to eq(100)
      expect(@item_1.unit_price_to_dollars).to eq('1.00')
      expect(@item_2.unit_price).to eq(15000)
      expect(@item_2.unit_price_to_dollars).to eq('150.00')
      expect(@item_3.unit_price).to eq(50000)
      expect(@item_3.unit_price_to_dollars).to eq('500.00')
    end
    
    it '#enabled' do
      expect(@item_1.enabled).to eq(true)
      expect(@item_2.enabled).to eq(true)
      @item_1.update(status: 1)
      expect(@item_1.enabled).to eq(false)
      expect(@item_2.enabled).to eq(true)
      @item_2.update(status: 1)
      expect(@item_2.enabled).to eq(false)
    end
    
    it '#disabled' do 
      expect(@item_1.disabled).to eq(false)
      expect(@item_2.disabled).to eq(false)
      @item_1.update(status: 1)
      expect(@item_1.disabled).to eq(true)
      expect(@item_2.disabled).to eq(false)
      @item_2.update(status: 1)
      expect(@item_2.disabled).to eq(true)
    end
  end

  describe 'class methods' do
    it '.top_five_by_revenue' do
      expect(Item.top_five_by_revenue(@merchant_1)).to eq([@item_1, @item_9, @item_5, @item_7, @item_8])
      expect(Item.top_five_by_revenue(@merchant_2)).to eq([@item_2, @item_3, @item_4, @item_6, @item_10])
    end
  end
end
