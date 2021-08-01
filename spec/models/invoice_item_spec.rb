require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'associations' do
    it {should belong_to :invoice}
    it {should belong_to :item}
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
      # @merchant1 = Merchant.create!(name: 'Korbanth')
      #
      # @item1 = @merchant1.items.create!(
      #   name: 'SK2',
      #   description: "Starkiller's lightsaber from TFU2 promo trailer",
      #   unit_price: 25_000)
      # @item2 = @merchant1.items.create!(
      #   name: 'Shtok eco',
      #   description: "Hilt side lit pcb",
      #   unit_price: 1_500)
      # @item3 = @merchant1.items.create!(
      #   name: 'Hat',
      #   description: "Signed by MJ",
      #   unit_price: 60_000)
      #
      # @customer1 = Customer.create!(
      #   first_name: 'Ben',
      #   last_name: 'Franklin')
      #
      # @invoice1 = @customer1.invoices.create!(status: 0)
      # @invoice2 = @customer1.invoices.create!(status: 1)
      #
      # @invoice_item1 = InvoiceItem.create!(
      #   item: @item1,
      #   invoice: @invoice1,
      #   quantity: 1,
      #   unit_price: 1_500,
      #   status: 0)
      # @invoice_item2 = InvoiceItem.create!(
      #   item: @item2,
      #   invoice: @invoice1,
      #   quantity: 1,
      #   unit_price: 25_000,
      #   status: 1)
      # @invoice_item3 = InvoiceItem.create!(
      #   item: @item3,
      #   invoice: @invoice2,
      #   quantity: 1,
      #   unit_price: 60_000,
      #   status: 1)
    end
    # describe '#change_status' do
    #   it 'updates the invoice item status' do
    #     expect(@invoice_item3.status).to eq('pending')
    #
    #     @invoice_item3.change_status('ShiPPed')
    #
    #     expect(@invoice_item3.status).to eq('shipped')
    #     expect(@invoice_item3.change_status('PAckaged')).to eq(true)
    #     expect(@invoice_item3.status).to eq('packaged')
    #   end
    # end
  end
end
