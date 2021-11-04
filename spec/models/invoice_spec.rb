require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :transactions}
  end

  describe '::pending_invoices' do
    it 'returns an array of pending invoices' do
      customer1 = Customer.create!(first_name: "Bob", last_name: "Dylan")
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 'in progress')
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 'in progress')
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 'completed')

      expect(Invoice.pending_invoices).to eq([invoice3, invoice1])
    end
  end
end