require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:invoice_id) }
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_presence_of(:result) }
  end

  describe 'class methods' do
    describe '::success_count' do
      it 'can count number of successful transactions' do
        @customer = create(:customer)

        @invoice = Invoice.create!(status: 0, customer_id: @customer.id)

        @transaction_1 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice.id)
        @transaction_2 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: @invoice.id)
        @transaction_3 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: @invoice.id)
        @transaction_4 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice.id)
        @transaction_5 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: @invoice.id)
        @transaction_6 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice.id)

        expect(Transaction.success_count).to eq(3)

        @transaction_7 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice.id)

        expect(Transaction.success_count).to eq(4)
      end
    end
  end
end
