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
end
