require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it {should belong_to(:customer)}
  end

  describe 'model tests' do 
    it 'should show incomplete invoices' do 
      @customer_1 = Customer.create!(first_name: "Sally", last_name: "Shopper")
      @customer_2 = Customer.create!(first_name: "Evan", last_name: "East")
      @customer_3 = Customer.create!(first_name: "Yasha", last_name: "West")
      @customer_4 = Customer.create!(first_name: "Du", last_name: "North")
      @customer_5 = Customer.create!(first_name: "Polly", last_name: "South")

      @invoice_1 = Invoice.create!(status: "in progress", customer_id: @customer_1.id)
      @invoice_2 = Invoice.create!(status: "cancelled", customer_id: @customer_2.id)
      @invoice_3 = Invoice.create!(status: "completed", customer_id: @customer_3.id)
      @invoice_4 = Invoice.create!(status: "in progress", customer_id: @customer_4.id)
      expect(Invoice.incomplete_invoices).to eq([@invoice_1, @invoice_2, @invoice_4])
    end
  end
end
