require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    let(:merchant) { create :merchant }

    it 'should respond to items' do
      expect(merchant).to respond_to(:items)
    end
  end
end
