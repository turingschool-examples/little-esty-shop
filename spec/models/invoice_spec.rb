require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer}
    it { should belong_to :merchant}
  end
  
  describe 'validations' do
    it { should validate_presence_of :status}
  end
  
  describe 'class methods' do
    it "shows incomplete invoices" do
    @merchant = Merchant.create!(name: 'House of thingys')

    @customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 0)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 1)
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 2)

    expect(Invoice.incomplete_invoices).to eq([@invoice_1.id])
    end
  end
end
