require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'class methods' do
    describe '::top_customers' do
      it 'returns the top 5 customers with largest number of successful transactions' do

        inv_1 = create(:invoice, status: 'completed')
        inv_2 = create(:invoice, status: 'completed')
        inv_3 = create(:invoice, status: 'completed')
        inv_4 = create(:invoice, status: 'completed')
        inv_5 = create(:invoice, status: 'completed')
        inv_6 = create(:invoice, status: 'completed')

        t_1 = Transaction.create!(invoice_id: inv_1.id, result: 'success')
        t_2 = Transaction.create!(invoice_id: inv_1.id, result: 'success')
        t_3 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
        t_4 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
        t_5 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
        t_6 = Transaction.create!(invoice_id: inv_3.id, result: 'success')
        t_7 = Transaction.create!(invoice_id: inv_2.id, result: 'success')
        t_8 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
        t_9 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
        t_10 = Transaction.create!(invoice_id: inv_5.id, result: 'success')
        t_11 = Transaction.create!(invoice_id: inv_5.id, result: 'success')
        t_12 = Transaction.create!(invoice_id: inv_5.id, result: 'success')
        t_13 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
        t_14 = Transaction.create!(invoice_id: inv_4.id, result: 'success')
        t_15 = Transaction.create!(invoice_id: inv_4.id, result: 'success')

        expect(Customer.top_customers.count).to eq(5)
      end
    end
  end
end
