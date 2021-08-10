require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'associations' do
    it {should belong_to :invoice}
    it {should belong_to :item}
    it {should have_many(:merchants).through(:item) }
    it {should have_many(:discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:unit_price).only_integer }
    it { should define_enum_for(:status).with_values([:packaged, :pending, :shipped]) }
  end

  describe 'instance methods' do
    before(:each) do
      @merchant1 = Merchant.create!(name: 'Korbanth')
      @merchant2 = Merchant.create!(name: 'asdf')

      @item1 = @merchant1.items.create!(
        name: 'SK2',
        description: "Starkiller's lightsaber from TFU2 promo trailer",
        unit_price: 25_000)
      @item2 = @merchant1.items.create!(
        name: 'Shtok eco',
        description: "Hilt side lit pcb",
        unit_price: 1_500)
      @item3 = @merchant1.items.create!(
        name: 'Hat',
        description: "Signed by MJ",
        unit_price: 60_000)
      @item4 = @merchant2.items.create!(
        name: 'what',
        description: "testy",
        unit_price: 10_000)

      @customer1 = Customer.create!(
        first_name: 'Ben',
        last_name: 'Franklin')

      @invoice1 = @customer1.invoices.create!(status: 0)
      @invoice2 = @customer1.invoices.create!(status: 1)

      @invoice_item1 = InvoiceItem.create!(
        item: @item1,
        invoice: @invoice1,
        quantity: 3,
        unit_price: 1_500,
        status: 1)
      @invoice_item2 = InvoiceItem.create!(
        item: @item2,
        invoice: @invoice1,
        quantity: 2,
        unit_price: 25_000,
        status: 1)
      @invoice_item3 = InvoiceItem.create!(
        item: @item3,
        invoice: @invoice2,
        quantity: 1,
        unit_price: 60_000,
        status: 1)
      @invoice_item4 = InvoiceItem.create!(
        item: @item4,
        invoice: @invoice2,
        quantity: 1,
        unit_price: 60_000,
        status: 1)

      @discount1 = @merchant1.discounts.create(name: 'Twoten', threshold: 2, percentage: 10)
      @discount2 = @merchant1.discounts.create(name: 'Fourscore', threshold: 3, percentage: 20)
      @discount3 = @merchant1.discounts.create(name: 'Ninetwentynine', threshold: 9, percentage: 29)
      @discount4 = @merchant1.discounts.create(name: 'Twentyfifty', threshold: 20, percentage: 50)

      @discount6 = @merchant2.discounts.create(name: 'Two', threshold: 100, percentage: 2)
    end

    describe '#full_amount' do
      it 'calculates the full amount of the invoice item' do
        expect(@invoice_item1.full_amount).to eq(45)
      end
    end

    describe '#invoice_item_discount' do
      it 'determines the discount to apply' do
        expect(@invoice_item1.invoice_item_discount).to eq(@discount2)
      end
    end

    describe '#revenue_after_discount' do
      it 'determines the amount of revenue after the discount is applied' do
        expect(@invoice_item1.revenue_after_discount).to eq(36)
      end

      it 'returns fthe full amount if no discount is eligible' do
        expect(@invoice_item4.revenue_after_discount).to eq(@invoice_item4.full_amount)
      end
    end
  end
end
