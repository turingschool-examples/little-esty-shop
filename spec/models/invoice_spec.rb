require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:status) }
  # end

  before :each do
    # enabled
    @merchant1 = Merchant.create!(name: "Tyler", status: 1)
    @merchant2 = Merchant.create!(name: "Jill", status: 1)
    @merchant3 = Merchant.create!(name: "Bob", status: 1)
    # disabled
    @merchant4 = Merchant.create!(name: "Johnny", status: 0)
    @merchant5 = Merchant.create!(name: "Carrot Top", status: 0)
    @merchant6 = Merchant.create!(name: "lil boosie", status: 0)

    @item1 = @merchant1.items.create!(name: "socks", description: "soft", unit_price: 3.00, status: 0)
    @item2 = @merchant2.items.create!(name: "watch", description: "bling-blang", unit_price: 400.00, status: 0)
    @item3 = @merchant3.items.create!(name: "skillet", description: "HOT!", unit_price: 45.00, status: 0)
    @item4 = @merchant4.items.create!(name: "3 Pack of Shirts", description: "comfy", unit_price: 18.00, status: 0)
    @item5 = @merchant5.items.create!(name: "shoes", description: "woah, fast boi!", unit_price: 67.00, status: 0)
    @item6 = @merchant6.items.create!(name: "dress", description: "brown-chicken-black-cow", unit_price: 250.00, status: 0)

    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")

    @invoice1 = @customer1.invoices.create!(status: 2)
    @invoice2 = @customer1.invoices.create!(status: 2)
    @invoice3 = @customer1.invoices.create!(status: 2)

    @transaction1 = @invoice1.transactions.create!(result: 1, credit_card_number: 4654405418249632)
    @transaction2 = @invoice1.transactions.create!(result: 1, credit_card_number: 4580251236515201)

    @transaction3 = @invoice2.transactions.create!(result: 1, credit_card_number: 4923661117104166)
    @transaction4 = @invoice2.transactions.create!(result: 0, credit_card_number: 4515551623735607)

    @transaction5 = @invoice3.transactions.create!(result: 1, credit_card_number: 4203696133194408)
    @transaction6 = @invoice3.transactions.create!(result: 1, credit_card_number: 4540842003561938)

    @invoice_item1 = @item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 1, invoice: @invoice1)
    @invoice_item2 = @item2.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 1, invoice: @invoice1)
    @invoice_item3 = @item3.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 1, invoice: @invoice2)
    @invoice_item4 = @item4.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 0, invoice: @invoice2)
    @invoice_item5 = @item5.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: @invoice3)
    @invoice_item6 = @item6.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: @invoice3)
  end

  describe 'instance methods' do
    describe '#unshipped' do
      it 'returns all invoices that are unshipped' do
        expected = [@invoice1, @invoice2]

        expect(Invoice.unshipped).to eq(expected)
      end
    end
  end

  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
end
