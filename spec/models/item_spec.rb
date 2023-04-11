require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }

  before :each do
    test_data
  end

  describe 'instance methods' do
    it '#unit_price_to_dollars' do
      expect(@item_1.unit_price_to_dollars).to eq('1.00')
      expect(@item_2.unit_price_to_dollars).to eq('150.00')
      expect(@item_3.unit_price_to_dollars).to eq('500.00')
    end
  end
end
