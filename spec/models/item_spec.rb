require 'rails_helper'

RSpec.describe Item do
  describe 'relations' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  
  describe 'instance methods' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'Ron Swanson')
      
      @item_1 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000)
      
      @customer_1 = Customer.create!(first_name: "Billy", last_name: "Joel")
      @customer_2 = Customer.create!(first_name: "Britney", last_name: "Spears")
      @customer_3 = Customer.create!(first_name: "Prince", last_name: "Mononym")
  
      @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')
      @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')
      @invoice_3 = @customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')
      @invoice_5 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')
      @invoice_6 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-29 12:54:09')
      @invoice_7 = @customer_1.invoices.create!(status: 1, created_at: '2012-05-28 12:54:09')
  
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1000, quantity: 1, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 900, quantity: 1, status: 0)
      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 1000, quantity: 1, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, unit_price: 900, quantity: 1, status: 0)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_3.id, unit_price: 1500, quantity: 3, status: 0)
    end

    describe '#date_with_most_sales' do
      it 'shows date' do
        expect(@item_1.date_with_most_sales).to eq("03/25/2012")
      end
    end
  end
end 
