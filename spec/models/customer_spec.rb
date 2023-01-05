require 'rails_helper'

RSpec.describe Customer do
  before :each do
    FactoryBot.reload
    @customers = FactoryBot.create_list(:customer_with_invoice, 10)
    @invoices = Invoice.all
    FactoryBot.create_list(:transaction, 6, result: 'success', invoice_id: @invoices[0].id)
    FactoryBot.create_list(:transaction, 5, result: 'success', invoice_id: @invoices[3].id)
    FactoryBot.create_list(:transaction, 4, result: 'success', invoice_id: @invoices[1].id)
    FactoryBot.create_list(:transaction, 3, result: 'success', invoice_id: @invoices[4].id)
    FactoryBot.create_list(:transaction, 2, result: 'success', invoice_id: @invoices[2].id)
  end

  describe "Relationships" do
    it {should have_many :invoices} 
    it {should have_many(:transactions).through(:invoices)}
  end

  describe '#successful_transactions' do
    it 'returns all the successful transactions' do
      expect(Customer.successful_transactions.count).to eq 20
    end
  end

  describe '#order_by_purchases' do
    it 'orders a customer-transaction join table by number of purchases' do
      expect(Customer.successful_transactions.order_by_purchases.first.id).to eq @customers[0].id
      expect(Customer.successful_transactions.order_by_purchases.fifth.id).to eq @customers[2].id
    end
  end

  describe '#top_customers' do
    it 'returns the 5 customers with most purchases' do
      expect(Customer.top_customers.first.id).to eq @customers[0].id
      expect(Customer.top_customers.fifth.id).to eq @customers[2].id
      expect(Customer.top_customers.count).to eq 5
    end
  end
end