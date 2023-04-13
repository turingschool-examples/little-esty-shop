require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
  end

  describe "instance methods" do
    describe 'customer_name' do
      it 'returns the name of the customer' do
        @customer = create(:customer, first_name: "Bob", last_name: "Smith")
        @invoice = create(:invoice, customer_id: @customer.id)

        expect(@invoice.customer_name).to eq("Bob Smith")
      end
    end
  end
end
