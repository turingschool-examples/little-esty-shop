require 'rails_helper'

RSpec.describe Item do
  describe 'associations' do
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).only_integer }
  end

  describe 'class methods' do
    before :each do
      @merchant = Merchant.create!(name: 'Lydia Rodarte-Quayle')
      @item_1 = Item.create!(name: 'P2P', description: 'secret...', unit_price: 1000, merchant_id: @merchant.id)
      @item_2 = Item.create!(name: '10 Gallon Drum', description: 'for storage', unit_price: 100, merchant_id: @merchant.id)
      @item_3 = Item.create!(name: 'Dolley', description: 'for transportation', unit_price: 10, merchant_id: @merchant.id)

      @customer_1 = Customer.create!(first_name: 'Tuco', last_name: 'Salamanca')
      @customer_1.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_1.invoices[0], item: @item_1, quantity: 1, unit_price: @item_1.unit_price, status: 1)
      @customer_1.invoices[0].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
      @customer_1.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_1.invoices[1], item: @item_2, quantity: 1, unit_price: @item_2.unit_price, status: 1)
      @customer_1.invoices[1].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

      @customer_2 = Customer.create!(first_name: 'Gustavo', last_name: 'Fring')
      @customer_2.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_2.invoices[0], item: @item_1, quantity: 2, unit_price: @item_1.unit_price, status: 1)
      @customer_2.invoices[0].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_2.invoices[1], item: @item_2, quantity: 4, unit_price: @item_2.unit_price, status: 2)
      @customer_2.invoices[1].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_2.invoices[2], item: @item_3, quantity: 1, unit_price: @item_3.unit_price, status: 1)
      @customer_2.invoices[2].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
    end

    it 'can return #items_ready_to_ship_by_ordered_date for a given merchant' do
      expected = Item.items_ready_to_ship_by_ordered_date(@merchant.id)

      expect(expected.length).to eq(4)
      expect(expected.all? { |item| item.class == Item } ).to be true
      expect(expected[0].invoice_id).to eq(@customer_1.invoices[0].id)
      expect(expected[1].invoice_id).to eq(@customer_1.invoices[1].id)
      expect(expected[2].invoice_id).to eq(@customer_2.invoices[0].id)
      expect(expected[3].invoice_id).to eq(@customer_2.invoices[2].id)
    end
  end
end
