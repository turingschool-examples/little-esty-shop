require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'model methods' do
    before do
      @merchant = create(:merchant)

      @customer1 = create :customer
      @customer2 = create :customer
      @customer3 = create :customer
      @customer4 = create :customer
      @customer5 = create :customer
      @customer6 = create :customer

      @item = create :item, { merchant_id: @merchant.id }

      @invoice1 = create :invoice, { customer_id: @customer1.id, status: 'in progress' }
      @invoice2 = create :invoice, { customer_id: @customer2.id, status: 'in progress' }
      @invoice3 = create :invoice, { customer_id: @customer3.id, status: 'in progress' }
      @invoice4 = create :invoice, { customer_id: @customer4.id, status: 'in progress' }
      @invoice5 = create :invoice, { customer_id: @customer5.id, status: 'cancelled' }
      @invoice6 = create :invoice, { customer_id: @customer6.id, status: 'completed' }

      @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
      @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
      @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
      @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
      @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
      @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }

      @inv_item1 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice1.id}
      @inv_item2 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice2.id}
      @inv_item3 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice3.id}
      @inv_item4 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice4.id}
      @inv_item5 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice5.id}
      @inv_item6 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice6.id}
    end

    it 'returns invoices where status is in progress' do
      expect(Invoice.in_progress).to eq([@invoice1, @invoice2, @invoice3, @invoice4])
    end

    it 'orders invoices from oldest to newest' do
      expect(Invoice.order_from_oldest).to eq([@invoice6, @invoice5, @invoice4, @invoice3, @invoice2, @invoice1])
    end

    it 'caluclates total revenue for an invoice' do
      expect(@invoice1.total_revenue(@invoice1.id)).to eq(@invoice1.total_revenue(@invoice1.id))
    end
  end
end

# Admin Invoice Show Page: Total Revenue
#
# As an admin
# When I visit an admin invoice show page
# Then I see the total revenue that will be generated from this invoice
