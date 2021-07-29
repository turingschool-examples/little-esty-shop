require 'rails_helper'

RSpec.describe Customer do
  describe 'associations' do
    it {should have_many :invoices}
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    # it { should validate_numericality_of(:length).only_integer }
  end

  describe 'class methods' do
    before :each do
      @merchant = Merchant.create!(name: 'Lydia Rodarte-Quayle')
      @item = Item.create!(name: 'P2P', description: 'secret...', unit_price: 1000, merchant_id: @merchant.id)

      @customer_1 = Customer.create!(first_name: 'Tuco', last_name: 'Salamanca')
      @customer_1.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_1.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_1.invoices[0].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)
      @customer_1.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_1.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_1.invoices[1].transactions.create!(credit_card_number: '1234', credit_card_expiration_date: '', result: 0)

      @customer_2 = Customer.create!(first_name: 'Hector', last_name: 'Salamanca')
      @customer_2.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_2.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_2.invoices[0].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_2.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_2.invoices[1].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_2.invoices[2], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_2.invoices[2].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)
      @customer_2.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_2.invoices[3], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_2.invoices[3].transactions.create!(credit_card_number: '5678', credit_card_expiration_date: '', result: 0)

      @customer_3 = Customer.create!(first_name: 'Gustavo', last_name: 'Fring')
      @customer_3.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_3.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_3.invoices[0].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_3.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_3.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_3.invoices[1].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)
      @customer_3.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_3.invoices[2], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_3.invoices[2].transactions.create!(credit_card_number: '9012', credit_card_expiration_date: '', result: 0)

      @customer_4 = Customer.create!(first_name: 'Jesse', last_name: 'Pinkman')
      @customer_4.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_4.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_4.invoices[0].transactions.create!(credit_card_number: '3456', credit_card_expiration_date: '', result: 0)

      @customer_5 = Customer.create!(first_name: 'Walter', last_name: 'White')
      @customer_5.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_5.invoices[0], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_5.invoices[0].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
      @customer_5.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_5.invoices[1], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_5.invoices[1].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
      @customer_5.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_5.invoices[2], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_5.invoices[2].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
      @customer_5.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_5.invoices[3], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_5.invoices[3].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)
      @customer_5.invoices.create!(status: 2)
      InvoiceItem.create!(invoice: @customer_5.invoices[4], item: @item, quantity: 1, unit_price: @item.unit_price, status: 1)
      @customer_5.invoices[4].transactions.create!(credit_card_number: '7891', credit_card_expiration_date: '', result: 0)

      @customer_6 = Customer.create!(first_name: 'Jack', last_name: 'Welker')
      @customer_7 = Customer.create!(first_name: 'Todd', last_name: 'Alquist')

    end

    it 'can return top 5 customers for a given merchant' do
      expected = Customer.top_customers_for_merchant(@merchant.id)

      expect(expected).to eq(
        [@customer_5, @customer_2, @customer_3, @customer_1, @customer_4]
      )
    end
  end

end
