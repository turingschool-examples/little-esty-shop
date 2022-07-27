require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:transactions) }
    it { should belong_to(:customer) }
    it { should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }
  end


  describe 'class methods' do
  end

  describe 'instance methods' do
    it '#total_revenue' do
      merchant_1 = Merchant.create!(name: "Pokemon Card Shop", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

      item_1 = merchant_1.items.create!(merchant_id: merchant_1.id, name: "Charizard Rare", description: "Mint Condition Charizard", unit_price: 13984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")
      item_2 = @merchant_1.items.create!(merchant_id: merchant_1.id, name: "Charizard Common", description: "Average Condition Charizard", unit_price: 3984, created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC")

      customer_1 = Customer.create!(first_name: "John", last_name: "Doe", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-28 14:54:10 UTC")

      invoice_1 = customer_1.invoices.create!(status: "in progress", created_at: "2013-03-27 14:54:10 UTC", updated_at: "2013-03-28 14:54:10 UTC", customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 'pending', quantity: 2, unit_price: 13984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, status: 'pending', quantity: 1, unit_price: 3984, created_at: "2013-03-29 14:54:10 UTC", updated_at: "2013-03-29 14:54:10 UTC")
      
      expect(invoice_1.total_revenue).to eq(31952)
    end
    
    it 'can format time' do
      customer = Customer.create!(first_name: "A", last_name: "A")
      invoice = Invoice.create!(status: "completed", customer_id: customer.id, created_at: "2022-07-26 00:00:00 UTC")

      expect(invoice.format_date).to eq("Tuesday, July 26, 2022")
    end
  end
    

end