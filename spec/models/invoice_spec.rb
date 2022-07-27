require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'instance methods' do
    it 'can format time' do
    customer = Customer.create!(first_name: "A", last_name: "A")
    invoice = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-26 00:00:00 UTC")

    expect(invoice.format_date).to eq("Tuesday, July 26, 2022")
    end
  end
end