require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    let(:transaction) {create :transaction}
    let(:status) { ['success', 'failed'] }

    it 'should respond to invoices' do
      expect(transaction).to respond_to(:invoice)
    end

    it 'has the right index' do
      status.each_with_index do |item, index|
        expect(Transaction.statuses[item]).to eq(index)
      end
    end
  end
end
