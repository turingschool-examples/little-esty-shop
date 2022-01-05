require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    it 'reports a merchants invoices' do
      merchant1 = create(:merchant)
      invoice1 = create(:invoice)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      expect(merchant1.invoice_finder).to eq [invoice1]
    end
  end

  describe 'instance methods' do
    describe 'top_customers' do
      it 'returns an array of the top customers based on the number of thier number completed invoices for the merchants items' do
        merchant = create(:merchant_with_completed_invoices, invoice_count: 20)
        customer_1 = create(:customer, first_name: 'Bob')
        customer_2 = create(:customer, first_name: 'John')
        customer_3 = create(:customer, first_name: 'Abe')
        customer_4 = create(:customer, first_name: 'Zach')
        customer_5 = create(:customer, first_name: 'Charlie')

        # Assign completed transactions to specific customers.
        first = merchant.invoices.first.id
        last = merchant.invoices.last.id
        merchant.invoices.where(id: first..first + 5).update(customer_id: customer_1.id)
        merchant.invoices.where(id: first + 6..first + 7).update(customer_id: customer_2.id)
        merchant.invoices.where(id: first + 8..first + 15).update(customer_id: customer_3.id)
        merchant.invoices.where(id: first + 16).update(customer_id: customer_4.id)
        merchant.invoices.where(id: first + 17..last).update(customer_id: customer_5.id)

        expect(merchant.top_customers(1)).to be_a(Array)
        expect(merchant.top_customers(1)).to eq([customer_3])
        expect(merchant.top_customers(2)).to eq([customer_3, customer_1])
        expect(merchant.top_customers(5)).to eq([customer_3, customer_1, customer_5, customer_2, customer_4])
      end
    end
  end
end
