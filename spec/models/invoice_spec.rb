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
    @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")
    invoice1 = @customer1.invoices.create!(status: 2)
    @merchant1 = Merchant.create!(name: "Billy", status: 1)
    item1 = @merchant1.items.create!(name: "shoes", description: "super fast boi, can't catch me boi", unit_price: 60.00, status: 1)
    6.times do |item1|
      item1
    end
    6.times do |invoice1|
      invoice1
    end
    @invoice_item1 = item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 0, invoice: invoice1)
    @invoice_item2 = item1.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 2, invoice: invoice1)
    @invoice_item3 = item1.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 1, invoice: invoice1)
    @invoice_item4 = item1.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 1, invoice: invoice1)
    @invoice_item5 = item1.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: invoice1)
    @invoice_item6 = item1.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: invoice1)
  end

  describe 'instance methods' do
    describe '#unshipped' do
      it 'returns all invoices that are unshipped' do
        @customer1 = Customer.create!(first_name: "Dr.", last_name: "Pepper")
        invoice1 = @customer1.invoices.create!(status: 2)
        @merchant1 = Merchant.create!(name: "Billy", status: 1)
        item1 = @merchant1.items.create!(name: "shoes", description: "super fast boi, can't catch me boi", unit_price: 60.00, status: 1)
        6.times do |item1|
          item1
        end
        6.times do |invoice1|
          invoice1
        end
        @invoice_item1 = item1.invoice_items.create!(quantity: 6, unit_price: 3.0, status: 0, invoice: invoice1)
        @invoice_item2 = item1.invoice_items.create!(quantity: 1, unit_price: 400.0, status: 2, invoice: invoice1)
        @invoice_item3 = item1.invoice_items.create!(quantity: 3, unit_price: 45.0, status: 1, invoice: invoice1)
        @invoice_item4 = item1.invoice_items.create!(quantity: 5, unit_price: 18.0, status: 1, invoice: invoice1)
        @invoice_item5 = item1.invoice_items.create!(quantity: 1, unit_price: 67.0, status: 2, invoice: invoice1)
        @invoice_item6 = item1.invoice_items.create!(quantity: 2, unit_price: 250.0, status: 2, invoice: invoice1)


        expected = [@invoice_item1.item.id, @invoice_item3.item.id, @invoice_item4.item.id]

        expect(invoice1.unshipped).to eq(expected)
      end
    end
  end

  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
end
