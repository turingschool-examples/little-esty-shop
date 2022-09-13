require "rails_helper"

RSpec.describe(Transaction, type: :model) do
  let(:transaction) { Transaction.new(invoice_id: 1, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success') }

  it("is an instance of transaction") do
    expect(transaction).to(be_instance_of(Transaction))
  end

  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'validations' do
    it { should validate_presence_of :invoice_id }
    it { should validate_numericality_of :invoice_id }
    it { should validate_presence_of :credit_card_number}
    it { should validate_numericality_of :credit_card_number }
    it { should validate_presence_of :credit_card_expiration_date}
    it { should validate_numericality_of :credit_card_expiration_date }
    it { should validate_presence_of :result}

    # it 'validations credit card number length' do
    #   Transaction.new(invoice_id: 1, credit_card_number: 123456789123456, credit_card_expiration_date: 0122, result: "success" ).should_not be_valid
    #   Transaction.new(invoice_id: 2, credit_card_number: 1234567891234567, credit_card_expiration_date: 0122, result: "success" ).should be_valid
    # end
  end
end