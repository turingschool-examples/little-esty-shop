require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do

    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}

  end

  describe 'status enum' do
    it 'should respond to enum methods' do
      customer = Customer.create!(first_name: "Gunther", last_name: "Guyman")
      invoice = Invoice.create!(customer_id: customer.id, status: 0)

      expect(invoice.in_progress?).to be(true)
      expect(invoice.status).to eq("in_progress")

      invoice.completed!
      expect(invoice.in_progress?).to be(false)
    end
  end
end
