require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
  end

  before(:each) do
    @customer_1  = Customer.create!(first_name: 'Tanya', last_name: 'Tiger')
    @invoice_1 = @customer_1.invoices.create!(status: 1)
    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_3 = @invoice_1.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_19 = @invoice_1.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

    @customer_2  = Customer.create!(first_name: 'Jerry', last_name: 'Jones')
    @invoice_2 = @customer_2.invoices.create!(status: 1)
    @transaction_4 = @invoice_2.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

    @customer_3  = Customer.create!(first_name: 'Adam', last_name: 'Asop')
    @invoice_3 = @customer_3.invoices.create!(status: 1)
    @invoice_4 = @customer_3.invoices.create!(status: 1)
    @transaction_5 = @invoice_3.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_6 = @invoice_3.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_7 = @invoice_4.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_8 = @invoice_4.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_9 = @invoice_4.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_20 = @invoice_4.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

    @customer_4  = Customer.create!(first_name: 'Sammy', last_name: 'Smith')
    @invoice_5 = @customer_4.invoices.create!(status: 1)
    @transaction_10 = @invoice_5.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 1)

    @customer_5  = Customer.create!(first_name: 'Derek', last_name: 'Davis')
    @invoice_6 = @customer_5.invoices.create!(status: 1)
    @transaction_11 = @invoice_6.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_12 = @invoice_6.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_13 = @invoice_6.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

    @customer_6  = Customer.create!(first_name: 'Robin', last_name: 'Ringer')
    @invoice_7 = @customer_6.invoices.create!(status: 1)
    @transaction_14 = @invoice_7.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_15 = @invoice_7.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)

    @customer_7  = Customer.create!(first_name: 'Yule', last_name: 'Young')
    @invoice_8 = @customer_7.invoices.create!(status: 1)
    @transaction_16 = @invoice_8.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_17 = @invoice_8.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
    @transaction_18 = @invoice_8.transactions.create!(credit_card_number: '1234567890987654', credit_card_expiration_date: '1220', result: 0)
  end

  describe '::top_five_by_transaction_success' do
    it 'lists top five customers by successful transactions' do
      expect(Customer.top_five_by_transaction_success).to eq([@customer_3, @customer_1, @customer_5, @customer_7, @customer_6])
    end
  end
end
