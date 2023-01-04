require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}    
    it {should validate_presence_of :name}
  end

  describe '#top_five_customers' do
    it 'returns the top 5 customers with most successful transactions with given merchant' do
      top5 = Merchant.find(2).top_five_customers

      expect(top5.length).to eq(5)
      expect(top5).to eq([Customer.find(1), Customer.find(10), Customer.find(11), Customer.find(3), Customer.find(12)])
    end
  end
end