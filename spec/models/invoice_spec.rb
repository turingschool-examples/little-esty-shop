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

  describe 'class methods' do
    before :each do
      test_data
    end
    describe 'invoice#incomplete' do
      it 'returns invoice items where status is not shipped' do
        @invoice_11 = Invoice.create!(status: "completed", customer: @customer_8)
        # @invoice_item_21 = InvoiceItem.create!(quantity: 95, unit_price: 54134, status: "packaged", item: @item_10, invoice: @invoice_11)
        expect(Invoice.incomplete.pluck(:id)).to eq([@invoice_1.id, @invoice_2.id, @invoice_3.id, @invoice_4.id, @invoice_5.id, @invoice_7.id, @invoice_8.id, @invoice_9.id])
      end
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

    describe '#created_at_formatted' do
      it 'shows date format correctly' do
        expect(@invoice_4.created_at_formatted).to eq(Date.today.strftime("%A, %B %d, %Y"))
      end
    end
  end
end
