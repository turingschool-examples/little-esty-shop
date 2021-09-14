require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    let(:status) { ['success', 'failed'] }

    it { should belong_to :invoice}

    it 'has the right index' do
      status.each_with_index do |item, index|
        expect(Transaction.statuses[item]).to eq(index)
      end
    end
  end
end
