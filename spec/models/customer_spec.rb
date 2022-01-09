require 'rails_helper'

RSpec.describe Customer do
  describe 'relations' do
    it { should have_many :invoices }
  end

    before :each do 
      @customer_1 = Customer.create!(first_name: "Billy", last_name: "Joel")
      @invoice_1 = @customer_1.invoices.create!(status: 1)
      @invoice_5 = @customer_1.invoices.create!(status: 1)
      @invoice_9 = @customer_1.invoices.create!(status: 1)
      @invoice_10 = @customer_1.invoices.create!(status: 1)
      @transaction_1 = @invoice_1.transactions.create!(result: 'success')
      @transaction_5 = @invoice_5.transactions.create!(result: 'failed')
      @transaction_9 = @invoice_9.transactions.create!(result: 'failed')
      @transaction_10 = @invoice_10.transactions.create!(result: 'failed')
      
      @customer_2 = Customer.create!(first_name: "Britney", last_name: "Spears")
      @invoice_2 = @customer_2.invoices.create!(status: 1)
      @invoice_6 = @customer_2.invoices.create!(status: 1)
      @transaction_2 = @invoice_2.transactions.create!(result: 'success')
      @transaction_6 = @invoice_6.transactions.create!(result: 'success')
      
      @customer_3 = Customer.create!(first_name: "Prince", last_name: "Mononym")
      @invoice_3 = @customer_3.invoices.create!(status: 1)
      @invoice_7 = @customer_3.invoices.create!(status: 1)
      @invoice_11 = @customer_3.invoices.create!(status: 1)
      @invoice_12 = @customer_3.invoices.create!(status: 1)
      @transaction_3 = @invoice_3.transactions.create!(result: 'failed')
      @transaction_7 = @invoice_7.transactions.create!(result: 'success')
      @transaction_11 = @invoice_11.transactions.create!(result: 'success')
      @transaction_12 = @invoice_12.transactions.create!(result: 'success')
     
      @customer_4 = Customer.create!(first_name: "Garfunkle", last_name: "Oates")
      @invoice_4 = @customer_4.invoices.create!(status: 1)      
      @invoice_8 = @customer_4.invoices.create!(status: 1)
      @invoice_13 = @customer_4.invoices.create!(status: 1)
      @invoice_14 = @customer_4.invoices.create!(status: 1)
      @transaction_4 = @invoice_4.transactions.create!(result: 'success')
      @transaction_8 = @invoice_8.transactions.create!(result: 'success')
      @transaction_13 = @invoice_13.transactions.create!(result: 'success')
      @transaction_14 = @invoice_14.transactions.create!(result: 'success')

      @customer_5 = Customer.create!(first_name: "Rick", last_name: "James")
      @invoice_15 = @customer_5.invoices.create!(status: 1)
      @invoice_16 = @customer_5.invoices.create!(status: 1)
      @invoice_17 = @customer_5.invoices.create!(status: 1)
      @invoice_18 = @customer_5.invoices.create!(status: 1)
      @invoice_19 = @customer_5.invoices.create!(status: 1)
      @transaction_15 = @invoice_15.transactions.create!(result: 'success')
      @transaction_16 = @invoice_16.transactions.create!(result: 'success')
      @transaction_17 = @invoice_17.transactions.create!(result: 'success')
      @transaction_18 = @invoice_18.transactions.create!(result: 'success')
      @transaction_19 = @invoice_19.transactions.create!(result: 'success')
      
      @customer_6 = Customer.create!(first_name: "Dave", last_name: "Chappelle")
      @invoice_20 = @customer_6.invoices.create!(status: 1)
      @transaction_20 = @invoice_20.transactions.create!(result: 'failed')
    end

    describe 'class methods' do
      describe '.top_5' do 
        it 'returns the top 5 customers ranked by successful transactions' do
          expect(Customer.top_5).to eq([@customer_5, @customer_4, @customer_3, @customer_2, @customer_1])
        end
      end 
    end 
end
