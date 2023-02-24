require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'transactions (user story 21)' do
    before do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)
      @customer4 = create(:customer)
      @customer5 = create(:customer)
      @customer6 = create(:customer)
      @customer7 = create(:customer)
      @customer8 = create(:customer)
      @invoice1 = create(:invoice, customer_id: @customer1.id)
      @invoice2 = create(:invoice, customer_id: @customer2.id)
      @invoice3 = create(:invoice, customer_id: @customer3.id)
      @invoice4 = create(:invoice, customer_id: @customer4.id)
      @invoice5 = create(:invoice, customer_id: @customer5.id)
      @invoice6 = create(:invoice, customer_id: @customer6.id)
      @invoice7 = create(:invoice, customer_id: @customer7.id)
      @invoice8 = create(:invoice, customer_id: @customer8.id)
      @transaction1_1 = create(:transaction, invoice_id: @invoice1.id, result: "success")
      @transaction1_2 = create(:transaction, invoice_id: @invoice1.id, result: "success")
      @transaction2_1 = create(:transaction, invoice_id: @invoice2.id, result: "success")
      @transaction2_2 = create(:transaction, invoice_id: @invoice2.id, result: "success")
      @transaction2_3 = create(:transaction, invoice_id: @invoice2.id, result: "success")
      @transaction3_1 = create(:transaction, invoice_id: @invoice3.id, result: "success")
      @transaction3_2 = create(:transaction, invoice_id: @invoice3.id, result: "success")
      @transaction4_1 = create(:transaction, invoice_id: @invoice4.id, result: "success")
      @transaction4_2 = create(:transaction, invoice_id: @invoice4.id, result: "success")
      @transaction5_1 = create(:transaction, invoice_id: @invoice5.id, result: "success")
      @transaction5_1 = create(:transaction, invoice_id: @invoice5.id, result: "success")
      @transaction6_1 = create(:transaction, invoice_id: @invoice6.id, result: "failed")
      @transaction6_2 = create(:transaction, invoice_id: @invoice6.id, result: "failed")
      @transaction6_3 = create(:transaction, invoice_id: @invoice6.id, result: "failed")
      @transaction6_4 = create(:transaction, invoice_id: @invoice6.id, result: "failed")
      @transaction6_5 = create(:transaction, invoice_id: @invoice6.id, result: "failed")
      @transaction7 = create(:transaction, invoice_id: @invoice7.id)
      @transaction8 = create(:transaction, invoice_id: @invoice8.id, result: "success")
    end
    
    describe '.top_5_by_transactions' do
      it 'counts successful transactions' do
        expect(Customer.top_5_by_transactions.sort).to eq([@customer1, @customer2, @customer3, @customer4, @customer5].sort)
      end

      it 'does not count failed transactions' do
        expect(Customer.top_5_by_transactions.sort).not_to include(@customer6)
      end
    end

    describe 'transaction_count' do
      it 'counts successful transactions' do
        expect(@customer1.transaction_count).to eq(2)
        expect(@customer2.transaction_count).to eq(3)
        expect(@customer8.transaction_count).to eq(1)
      end

      it 'does not count unsuccessful transactions' do
        expect(@customer6.transaction_count).to eq(0)
      end
    end
  end
end