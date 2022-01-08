require 'rails_helper'

RSpec.describe Customer do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  it '#successful_transactions_count' do
    expect(@customer_6.transactions.count).to eq(6)
    expect(@customer_6.successful_transactions_count).to eq(4)
  end

  describe 'class methods' do
    it '::top_customers' do
      expect(Customer.top_customers).to eq([@customer_4, @customer_5, @customer_6, @customer_3, @customer_2])
    end
  end
end
