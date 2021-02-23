require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
  end
  describe 'validations' do
    it { should validate_presence_of :credit_card_number}

    it 'result can be nil by default' do
      transaction = create(:transaction, result: nil)
      expect(transaction.result).to eq(nil)
      expect(transaction.success?).to eq(false)
      expect(transaction.failed?).to eq(false)
    end
    it 'result can be success' do
      transaction = create(:transaction, result: :success)
      expect(transaction.result).to eq("success")
      expect(transaction.success?).to eq(true)
      expect(transaction.failed?).to eq(false)
    end
    it 'result can be failed' do
      transaction = create(:transaction, result: :failed)
      expect(transaction.result).to eq('failed')
      expect(transaction.success?).to eq(false)
      expect(transaction.failed?).to eq(true)
    end
  end
end
