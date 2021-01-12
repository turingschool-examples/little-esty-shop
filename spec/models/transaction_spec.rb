require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "relationships" do
    it { should belong_to :invoice }
  end

  describe 'class methods' do
    it 'finds all successful transactions' do
      customer1 = Customer.create!(id: 1, first_name: 'Joey', last_name: 'Ondricka')
      customer3 = Customer.create!(id: 3, first_name: 'Mariah', last_name: 'Toy')

      merchant26 = Merchant.create!(id: 26, name: 'Balistreri, Schaefer and Kshlerin')
      merchant75 = Merchant.create!(id: 75, name: 'Eichmann-Turcotte')
      merchant33 = Merchant.create!(id: 33, name: 'Quitzon and Sons')
      merchant8 = Merchant.create!(id: 8, name: 'Osinski, Pollich and Koelpin')

      inv1 = Invoice.create!(id: 1, customer_id: 1, merchant_id: 26, status: 'cancelled')
      inv2 = Invoice.create!(id: 2, customer_id: 1, merchant_id: 75, status: 'cancelled')
      inv4 = Invoice.create!(id: 4, customer_id: 1, merchant_id: 33, status: 'completed')
      inv12 = Invoice.create!(id: 12, customer_id: 3, merchant_id: 8, status: 'in progress')

      trans1 = Transaction.create!(id: 1, invoice_id: 1, credit_card_number: 	4654405418249632, result: 'success')
      trans2 = Transaction.create!(id: 2, invoice_id: 2, credit_card_number: 	4654405418249632, result: 'success')
      trans3 = Transaction.create!(id: 3, invoice_id: 4, credit_card_number: 	4654405418249632, result: 'failed')
      trans4 = Transaction.create!(id: 11, invoice_id: 12, credit_card_number: 	4654405418249632, result: 'failed')

      expect(Transaction.all_successful_transactions).to eq([trans1, trans2])
    end
  end
end
