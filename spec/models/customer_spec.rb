require 'rails_helper'

RSpec.describe Customer do
  before(:each) do
  end

  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'class methods' do
    describe 'top_customers' do
      it 'returns the top 5 customer by number of successful transactions' do
        top_customers = Customer.top_five
        
        expect(top_customers[0].name).to eq("Parker Daugherty")
        expect(top_customers[1].name).to eq("Ramona Reynolds")
        expect(top_customers[2].name).to eq("Joey Ondricka")
        expect(top_customers[3].name).to eq("Leanne Braun")
        expect(top_customers[4].name).to eq("Dejon Fadel")
      end
    end

    # I know this test is absolutely massive but there weren't enough relationships in the truncated data
    # to properly test this method. I'll add these to the truncated data set tomorrow. 
    describe 'top_customers_by_merchant' do
      it 'returns the top 5 customer with successful transactions by merchant' do
        @merchant = Merchant.create!(name: 'Sally Handmade')
        @item =  @merchant.items.create!(name: 'Qui Esse', description: 'Lorem ipsim', unit_price: 75107)
        @customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 
        @customer_2 = Customer.create!(first_name: 'Andrew', last_name: 'Brae')
        @customer_3 = Customer.create!(first_name: 'Yaho', last_name: 'Yoo')
        @customer_4 = Customer.create!(first_name: 'Sjarn', last_name: 'Max')
        @customer_5 = Customer.create!(first_name: 'Blers', last_name: 'Moushca')
        @customer_6 = Customer.create!(first_name: 'Knot', last_name: 'Top')

        @invoice = Invoice.create!(customer_id: @customer.id, status: 'completed')
        @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 'completed')
        @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 'completed')
        @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 'completed')
        @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 'completed')
        @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 'completed')
        @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 'completed')

        InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice_2.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice_3.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice_4.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice_5.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: @item.id, invoice_id: @invoice_6.id, quantity: 539, unit_price: 13635, status: 1)
        
        @invoice.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
        @invoice.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
        @invoice.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
        @invoice_2.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
        @invoice_2.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
        @invoice_2.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
        @invoice_2.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
        @invoice_2.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
        @invoice_2.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
        @invoice_3.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
        @invoice_3.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
        @invoice_3.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
        @invoice_4.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
        @invoice_4.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
        @invoice_4.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
        @invoice_5.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
        @invoice_5.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
        @invoice_5.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
        @invoice_6.transactions.create!(credit_card_number: 1322556767, credit_card_expiration_date: nil,result: 'success')
        @invoice_6.transactions.create!(credit_card_number: 1322556768, credit_card_expiration_date: nil,result: 'success')
        @invoice_6.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')
        @invoice_7.transactions.create!(credit_card_number: 1322556769, credit_card_expiration_date: nil,result: 'success')

        top_customers = @merchant.customers.top_five(@merchant_id)
     
        expect(top_customers[0].name).to eq("Yaho Yoo")
        expect(top_customers[1].name).to eq("Andrew Brae")
        expect(top_customers[2].name).to eq("Joey Ondricka")
        expect(top_customers[3].name).to eq("Sjarn Max")
        expect(top_customers[4].name).to eq("Blers Moushca")
      end
    end
  end

  describe 'instance methods' do
    describe '.full_name' do
      it 'returns full_name of customer' do
        customer = Customer.create!(first_name: 'Joey', last_name: 'Ondricka') 

        expect(customer.full_name).to eq ('Joey Ondricka')
      end
    end
  end
end
