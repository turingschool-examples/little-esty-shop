require 'rails_helper'

RSpec.describe Customer do
  describe 'Relationships' do
    it { should have_many :invoices }
    it { should have_many :transactions }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  it 'Selects the top 5 customers by successful transaction' do
    expect(Customer.top_5_by_transactions).to eq([Customer.find(12), Customer.find(13), Customer.find(7),
                                                  Customer.find(10), Customer.find(1)])
  end

  it 'Counts the number of successful transactions' do
    expect(Customer.find(12).transactions_count).to eq(9)
  end
end
