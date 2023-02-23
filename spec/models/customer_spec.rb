require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'top customers by transactions' do
    
    it 'produces the top customers for a transaction' do
      customer1 = create(:customer)
      customer2 = create(:customer)
      customer3 = create(:customer)
      customer4 = create(:customer)
      customer5 = create(:customer)
      customer6 = create(:customer)
      customer7 = create(:customer)
      customer8 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id)
      invoice2 = create(:invoice, customer_id: customer2.id)
      invoice3 = create(:invoice, customer_id: customer3.id)
      invoice4 = create(:invoice, customer_id: customer4.id)
      invoice5 = create(:invoice, customer_id: customer5.id)
      transaction1_1 = create(:transaction, invoice_id: invoice1.id)
      transaction1_2 = create(:transaction, invoice_id: invoice1.id)
      transaction2_1 = create(:transaction, invoice_id: invoice2.id)
      transaction2_2 = create(:transaction, invoice_id: invoice2.id)
      transaction3_1 = create(:transaction, invoice_id: invoice3.id)
      transaction3_2 = create(:transaction, invoice_id: invoice3.id)
      transaction4_1 = create(:transaction, invoice_id: invoice4.id)
      transaction4_2 = create(:transaction, invoice_id: invoice4.id)
      transaction5_1 = create(:transaction, invoice_id: invoice5.id)
      transaction5_1 = create(:transaction, invoice_id: invoice5.id)
      transaction6 = create(:transaction, invoice_id: invoice6.id)
      transaction7 = create(:transaction, invoice_id: invoice7.id)
      transaction8 = create(:transaction, invoice_id: invoice8.id)
      expect(Customer.top_5_by_transactions.sort).to eq([customer1, customer2, customer3, customer4, customer5].sort)
    end
  end
end