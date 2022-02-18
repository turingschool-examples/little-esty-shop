require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :credit_card_number }
    # see if Mike wants us to validate this or not before merging 
    # it { should validate_presence_of :credit_card_expiration_date }
    it { should validate_presence_of :result }
  end

  it 'exists' do
    transaction = create(:transaction)
    expect(transaction).to be_a(Transaction)
    expect(transaction). to be_valid
  end

  describe 'relationships' do
    it  { should belong_to(:invoice) }
  end
end
