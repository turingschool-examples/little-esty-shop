require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validation' do
    it { should define_enum_for(:status).with([:packaged, :pending, :shipped]) }
  end

  describe 'relations' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'instance methods' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'Ron Swanson')

      @item_1 = @merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)
      @item_2 = @merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100)

      @customer_1 = Customer.create!(first_name: "Billy", last_name: "Joel")
      @customer_2 = Customer.create!(first_name: "Britney", last_name: "Spears")

      @invoice_1 = @customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')
      @invoice_2 = @customer_2.invoices.create!(status: 1, created_at: '2012-03-25 08:54:09')

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, status: 0)
    end

    describe '#invoice_creation_date' do
      it 'converts the invoice item invoice creation date to Day of Week, MM DD,YYYY' do
        expect(@invoice_item_1.invoice_creation_date).to eq('Sunday, March 25,2012')
      end
    end
  end
end
