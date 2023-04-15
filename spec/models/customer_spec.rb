require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'relationships' do
    it {should have_many(:invoices)}
  end

  describe 'class methods' do
    before do
      test_data
    end

    it '#top_five' do
      @transaction_21 = @invoice_4.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_22 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_23 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_24 = @invoice_6.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_25 = @invoice_7.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_26 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)
      @transaction_27 = @invoice_1.transactions.create!(credit_card_number: 1, credit_card_expiration_date: 1, result: 1)

      expect(Customer.top_five).to eq([@customer_6, @customer_3, @customer_1, @customer_5, @customer_2])
    end
  end
end