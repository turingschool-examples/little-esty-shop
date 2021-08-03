require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'merchants' do
    describe 'class methods' do
      describe '#top_five' do
        it 'returns the top 5 customers name with revenue' do
          merchant = Merchant.create!(name:'Bobby Crafts')
          item = merchant.items.create!(name: "Foot Creame", description: "Please Not This", unit_price: 1350)
          customer = Customer.create!(first_name: 'Sally', last_name: 'Mendez')
          customer2 = Customer.create!(first_name: 'Sammy', last_name: 'Smith')
          customer3 = Customer.create!(first_name: 'Trevor', last_name: 'William')
          customer4 = Customer.create!(first_name: 'Drew', last_name: 'Hammond')
          customer5 = Customer.create!(first_name: 'Justin', last_name: 'Mcafee')
          customer6 = Customer.create!(first_name: 'Aaron', last_name: 'Jones')

          invoice = Invoice.create!(customer_id: customer.id, status: 'completed')
          invoice2 = Invoice.create!(customer_id: customer2.id, status: 'completed')
          invoice3 = Invoice.create!(customer_id: customer2.id, status: 'completed')
          invoice4 = Invoice.create!(customer_id: customer3.id, status: 'completed')
          invoice5 = Invoice.create!(customer_id: customer4.id, status: 'completed')
          invoice6 = Invoice.create!(customer_id: customer5.id, status: 'completed')
          invoice7 = Invoice.create!(customer_id: customer6.id, status: 'completed')

          InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 539, unit_price: 13635, status: 1)
          InvoiceItem.create!(item_id: item.id, invoice_id: invoice2.id, quantity: 539, unit_price: 13635, status: 1)
          InvoiceItem.create!(item_id: item.id, invoice_id: invoice3.id, quantity: 539, unit_price: 13635, status: 1)
          InvoiceItem.create!(item_id: item.id, invoice_id: invoice4.id, quantity: 539, unit_price: 13635, status: 1)
          InvoiceItem.create!(item_id: item.id, invoice_id: invoice5.id, quantity: 539, unit_price: 13635, status: 1)
          InvoiceItem.create!(item_id: item.id, invoice_id: invoice6.id, quantity: 539, unit_price: 13635, status: 1)

          invoice.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
          invoice.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
          invoice2.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice2.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
          invoice2.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
          invoice2.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice2.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
          invoice2.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
          invoice3.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice4.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice4.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
          invoice5.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice5.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
          invoice5.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
          invoice5.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice6.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice6.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
          invoice6.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
          invoice7.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
          invoice7.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')

          best_customers = Customer.merchant_top_five(merchant.id)

          expect(best_customers[0].full_name).to eq('Sammy Smith')
        end
      end
    end
  end

  describe 'admin' do
    before(:each) do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @customer3 = create(:customer)
      @customer4 = create(:customer)
      @customer5 = create(:customer)
      @customer6 = create(:customer)

      invoice1 = create(:invoice, customer_id: @customer1.id)
      invoice2 = create(:invoice, customer_id: @customer2.id)
      invoice3 = create(:invoice, customer_id: @customer3.id)
      invoice4 = create(:invoice, customer_id: @customer4.id)
      invoice5 = create(:invoice, customer_id: @customer5.id)
      invoice6 = create(:invoice, customer_id: @customer6.id)

      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice1.id)
      transaction3 = create(:transaction, invoice_id: invoice2.id)
      transaction4 = create(:transaction, invoice_id: invoice3.id)
      transaction5 = create(:transaction, invoice_id: invoice4.id)
      transaction6 = create(:transaction, invoice_id: invoice5.id)
      transaction7 = create(:transaction, invoice_id: invoice6.id)

      Transaction.last(1).map { |t| t.update!(result: 1) }
    end

    describe 'class methods' do
      describe '#top_customers' do
        it 'finds the top 5 customers' do
          expected = Customer.first(5)
          # require 'pry'; binding.pry
          expect(Customer.top_customers.sort).to eq(expected.sort)
        end
      end
    end

    describe 'instance methods' do
      it '::successful_transactions' do
        expect(@customer1.successful_transactions).to eq(3)
      end
    end
  end
end
