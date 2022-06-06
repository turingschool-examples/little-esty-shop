require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'class methods' do
    before :each do
      @merch1 = Merchant.create!(name: 'Floopy Fopperations')
      @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
      @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
      @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
      @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
      @item4 = @merch1.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
      @invoice1 = @customer1.invoices.create!(status: 2)
      @invoice2 = @customer1.invoices.create!(status: 2)
      @invoice3 = @customer1.invoices.create!(status: 2)
      @invoice4 = @customer1.invoices.create!(status: 1)
      InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 0,
                          created_at: '2022-06-02 21:08:18 UTC')
      InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 1000, status: 1,
                          created_at: '2022-06-01 21:08:15 UTC')
      InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 5, unit_price: 1000, status: 1,
                          created_at: '2022-06-03 21:08:15 UTC')
      InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 1000, status: 2,
                          created_at: '2022-06-03 21:08:15 UTC')

      it 'gets invoices with items not shipped' do
        expect(Invoice.all.incomplete).to match_array([@invoice1, @invoice2, @invoice3])
      end
    end
  end
end
