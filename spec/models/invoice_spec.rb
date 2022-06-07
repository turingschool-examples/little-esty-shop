require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'instance methods' do
    before :each do
      @merch1 = Merchant.create!(name: 'Floopy Fopperations')
      @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
      @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
      @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)

      @merch2 = Merchant.create!(name: 'Goopy Gopperations')
      @item4 = @merch2.items.create!(name: 'Goopy Original', description: 'the bester', unit_price: 1450)
      @item5 = @merch2.items.create!(name: 'Goopy Updated', description: 'the even better', unit_price: 1950)

      @cust1 = Customer.create!(first_name: 'Mark', last_name: 'Ruffalo')

      @inv1 = @cust1.invoices.create!(status: 'in progress')
      @inv2 = @cust1.invoices.create!(status: 'completed')

      @ii1 = InvoiceItem.create!(item_id: @item1.id.to_s, invoice_id: @inv1.id.to_s, quantity: 100,
                                 unit_price: 1000, status: 1)
      @ii2 = InvoiceItem.create!(item_id: @item2.id.to_s, invoice_id: @inv1.id.to_s, quantity: 200,
                                 unit_price: 2000, status: 1)
      @ii3 = InvoiceItem.create!(item_id: @item4.id.to_s, invoice_id: @inv2.id.to_s, quantity: 300)
    end

    describe '#invoice_total_revenue(merch_id)' do
      it 'calculates total revenue of an invoice' do
        expect(@inv1.total_revenue(@merch1.id)).to eq(500_000)
      end
    end

    describe '#invoice_get_invoice_item(item_id)' do
      it 'calculates total revenue of an invoice' do
        expect(@inv2.get_invoice_item(@item4.id)).to eq(@ii3)
      end
    end

    describe '#invoice_revenue' do
      it 'calculates total revenue of an invoice' do
        @ii4 = InvoiceItem.create!(item_id: @item2.id.to_s, invoice_id: @inv1.id.to_s, quantity: 1,
                                   unit_price: 2000, status: 1)
        expect(@inv1.invoice_revenue).to eq(502_000)
      end
    end
  end

  describe 'class methods' do
    before :each do
      @merch1 = Merchant.create!(name: 'Floopy Fopperations')
      @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
      @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
      @item2 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 950)
      @item3 = @merch1.items.create!(name: 'Floopy Retro', description: 'the OG', unit_price: 550)
      @item4 = @merch1.items.create!(name: 'Floopy Geo', description: 'the OG', unit_price: 550)
      @invoice1 = @customer1.invoices.create!(status: 2, created_at: '2022-06-02 21:08:18 UTC')
      @invoice2 = @customer1.invoices.create!(status: 2, created_at: '2022-06-03 21:08:18 UTC')
      @invoice3 = @customer1.invoices.create!(status: 2, created_at: '2022-06-01 21:08:18 UTC')
      @invoice4 = @customer1.invoices.create!(status: 1)
      InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 1000, status: 0,
                          created_at: '2022-06-02 21:08:18 UTC')
      InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 5, unit_price: 1000, status: 1,
                          created_at: '2022-06-01 21:08:15 UTC')
      InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 5, unit_price: 1000, status: 1,
                          created_at: '2022-06-03 21:08:15 UTC')
      InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 1000, status: 2,
                          created_at: '2022-06-03 21:08:15 UTC')
    end
    it 'gets invoices with items not shipped in ascending order' do
      expect(Invoice.all.incomplete).to match_array([@invoice3, @invoice1, @invoice2])
    end
  end
end
