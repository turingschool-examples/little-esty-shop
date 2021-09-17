require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
  end

  describe 'instance methods' do
    it 'returns the date in words-ish' do
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled', created_at: "2012-03-25 09:54:09 UTC")

      expect(invoice_1.formatted_date).to eq("Sunday, March 25, 2012")
    end

    it 'returns invoice customer full name' do
      customer_1 = Customer.create(id: 1, first_name: 'Bob', last_name: 'Johnson')
      invoice_1 = Invoice.create(id: 1, customer_id: customer_1.id, status: 'cancelled')

      expect(invoice_1.customer_full_name).to eq("Bob Johnson")
    end
  end
end
