require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before :each do
    @customer = Customer.create!(first_name: "Joe", last_name: "Smith")
    @invoice = @customer.invoices.create!(status: 0)
    @transaction1 = @invoice.transactions.create!(credit_card_number: "123", result:0)
    @transaction2 = @invoice.transactions.create!(credit_card_number: "234", result:1)
    @transaction3 = @invoice.transactions.create!(credit_card_number: "345", result:0)
  end

  describe "relationships" do
    it {should belong_to :invoice}
  end

  describe 'enum' do
    it 'displays results' do
      expect(@transaction1.result).to eq("success")
      expect(@transaction1.result).to_not eq("failed")
      expect(@transaction2.result).to eq("failed")
      expect(@transaction2.result).to_not eq("success")
    end
  end
end