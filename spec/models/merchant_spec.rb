require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
  end

  describe 'instance methods' do
    it '#packaged_items' do
      expect(merchant.packaged_items).to eq([item1, item2, item3])
    end
  end
end
