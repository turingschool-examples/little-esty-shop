require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) } 
  end
  
  describe 'enums' do
    it do
      should define_enum_for(:status).
     with_values(["in progress", "completed", "cancelled"])
    end
  end

  describe 'instance methods' do
    before :each do
      test_data
    end
    describe 'total revenue' do
      it 'returns the total revenue from all items on the invoice.' do
        expect(@invoice_4.total_revenue).to eq(3300000)
      end
    end

    describe 'created_at_formatted' do
      it "formats the created at attribute" do 
        customer = Customer.create!(first_name: "John", last_name: "Doe")
        invoice = Invoice.create!(status: "cancelled", customer: customer)
        expect(invoice.created_at_formatted).to eq(Date.today.strftime("%A, %B %d, %Y"))
      end
    end

    describe 'customer_full_name' do
      it 'returns customers first and last name' do
        expect(@invoice_8.customer_full_name).to eq("Sally Williams")
      end
    end
  end
end
