require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
  end

  describe '#top_customers' do
    before(:each) do
      @merchant = Merchant.first
    end
    it 'returns the top 5 customers for the given merchant' do

      expect(@merchant.top_customers.length).to eq(5)
    end
  end
end
