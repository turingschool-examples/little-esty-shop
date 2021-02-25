require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to(:customer) }
  end

  describe 'class methods' do
    it '.incomplete' do
      @customer = Customer.create!(first_name: "First1", last_name: "Last1")

      @invoice1 = @customer.invoices.create!(status: 0)
      @invoice2 = @customer.invoices.create!(status: 1)
      @invoice3 = @customer.invoices.create!(status: 2)
      @invoice4 = @customer.invoices.create!(status: 1)

      expect(@customer.invoices.incomplete).to eq([@invoice1, @invoice2, @invoice4])
    end
  end
end
