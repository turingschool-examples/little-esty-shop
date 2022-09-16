require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe '#instance methods' do
    it 'has a full name' do
      customer = create(:customer)
      expect(customer.name).to eq("#{customer.first_name} #{customer.last_name}")
    end

    it 'can return list of top 5 customers in descending order of completed invoices' do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    @invoice_list_1 = create_list(:invoice, 1, customer_id: @customer1.id)
    @failed_invoices_1 = create_list(:invoice, 3, customer_id: @customer1.id)
    @invoice_list_2 = create_list(:invoice, 2, customer_id: @customer2.id)
    @invoice_list_3 = create_list(:invoice, 3, customer_id: @customer3.id)
    @invoice_list_4 = create_list(:invoice, 4, customer_id: @customer4.id)
    @invoice_list_5 = create_list(:invoice, 5, customer_id: @customer5.id)
    @invoice_list_6 = create_list(:invoice, 6, customer_id: @customer6.id)

    invoices = [@invoice_list_1, @invoice_list_2, @invoice_list_3, @invoice_list_4, @invoice_list_5, @invoice_list_6].flatten

    invoices.each do |invoice|
      create(:transaction, invoice_id: invoice.id, result: :success)
    end
    @failed_invoices_1.each do |invoice|
      create(:transaction, invoice_id: invoice.id, result: :failed)
    end

    expect(Customer.top_five_cust).to eq([ @customer6, @customer5, @customer4, @customer3, @customer2])
    expect(Customer.top_five_cust.first.transaction_count).to eq(6)
    end
  end
end
