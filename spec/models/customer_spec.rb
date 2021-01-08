require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :merchants }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many :items }
  end

  describe "class methods" do
    it "can get top 5 customers by successful transactions" do
      expect(Customer.top_five.first).to eq(Customer.find(507))
      expect(Customer.top_five.last).to eq(Customer.find(948))
    end
  end

  describe "instance methods" do
    it "can get count of successful transactions" do
      expect(Customer.first.successful_count).to eq(7)
    end
  end

end