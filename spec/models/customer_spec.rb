require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
  end

  describe "instance methods" do
    describe "#name" do
      it "returns the customers full name" do
        customer = Customer.create!(first_name: "Bob", last_name: "Jones")
        expect(customer.name).to eq("Bob Jones")
      end
    end
  end
end
