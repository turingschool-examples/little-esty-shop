require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should have_many :invoices }
  end

  describe "instance methods" do
    it "#sucsessful_transaction_count" do
      @customer = Customer.create!(first_name: "First1", last_name: "Last1")

      @invoice1 = @customer.invoices.create!(status: 1)
      @transaction1 = @invoice1.transactions.create!(result: 0)
      @invoice2 = @customer.invoices.create!(status: 1)
      @transaction2 = @invoice2.transactions.create!(result: 0)

      expect(@customer.sucsessful_transaction_count).to eq(2)
    end
  end
end
