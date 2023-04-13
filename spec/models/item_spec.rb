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
      expect(@item_1.unit_price_to_dollars).to eq('1.00')
      expect(@item_2.unit_price_to_dollars).to eq('150.00')
      expect(@item_3.unit_price_to_dollars).to eq('500.00')
    end
  end
end
