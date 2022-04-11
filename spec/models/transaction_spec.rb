require 'rails_helper'

RSpec.describe Transaction do
  before :each do
    @customer = Customer.create!(first_name: "Billy", last_name: "Jonson",
                                 created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                 updated_at: Time.parse('2012-03-27 14:54:09 UTC'))

    @invoice = @customer.invoices.create!(status: "in progress",
                                          created_at: Time.parse('2012-03-25 09:54:09 UTC'),
                                          updated_at: Time.parse('2012-03-25 09:54:09 UTC'))

    @transaction = @invoice.transactions.create!(credit_card_number: 4654405418249632, result: 'success',
                                                         created_at: Time.parse('2012-03-27 14:54:09 UTC'),
                                                         updated_at: Time.parse('2012-03-27 14:54:09 UTC'))
  end

  context 'readable attributes' do
    it 'has a credit card' do
      expect(@transaction.credit_card_number).to eq('4654405418249632')
    end

    it 'has a result' do
      expect(@transaction.result).to eq('success')
    end
  end

  context 'validations' do
    it { should validate_presence_of :credit_card_number }
    it { should validate_numericality_of :credit_card_number }

    it { should validate_presence_of :result }
    it { should define_enum_for(:result) }
  end

  context 'relationships' do
    it { should belong_to :invoice }
  end
end
