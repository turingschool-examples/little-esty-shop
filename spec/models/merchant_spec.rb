require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}    
    it {should validate_presence_of :name}
  end

  describe '#top_five_customers' do
    it 'does things' do
      Merchant.find(2).top_five_customers
    end
  end
end