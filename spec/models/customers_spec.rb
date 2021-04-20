require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'class methods' do
    before(:each) do
      @merchant = Merchant.create!(name: 'Ice Cream Parlour')
      @item_1 = @merchant.items.create!(name: 'Ice Cream Scoop', description: 'scoops ice cream', unit_price: 13)
      @item_2 = @merchant.items.create!(name: 'Ice Cream Cone', description: 'holds ice cream', unit_price: 3)
      @customer = Customer.create!(first_name: 'Stuart', last_name: 'Little')
      @customer_1 = Customer.create!(first_name: 'Little', last_name: 'Stauart')
      @customer_2 = Customer.create!(first_name: 'Racoon', last_name: 'Stauart')
      @customer_3 = Customer.create!(first_name: 'Lil', last_name: 'Stauart')
      @customer_4 = Customer.create!(first_name: 'Weee', last_name: 'Stauart')
      @customer_5 = Customer.create!(first_name: 'Massive', last_name: 'Stauart')
      @invoice_1 = Invoice.create!(status: 0, customer_id: "#{@customer.id}")
      @invoice_2 = Invoice.create!(status: 0, customer_id: "#{@customer_1.id}")
      @invoice_3 = Invoice.create!(status: 0, customer_id: "#{@customer_2.id}")
      @invoice_4 = Invoice.create!(status: 0, customer_id: "#{@customer_3.id}")
      @invoice_5 = Invoice.create!(status: 0, customer_id: "#{@customer_4.id}")
      @invoice_6 = Invoice.create!(status: 0, customer_id: "#{@customer_5.id}")
      InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 40, status: 0)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 20, status: 2)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 20, status: 2)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_4.id, quantity: 10, unit_price: 20, status: 2)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_5.id, quantity: 10, unit_price: 20, status: 2)
      InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_6.id, quantity: 10, unit_price: 20, status: 2)
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_1.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_2.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_3.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_4.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_5.id}")
      @transaction = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: "#{@invoice_6.id}")
    end

    describe "::top_five_customers" do
      it 'lists the top five customers for a merchant' do

        expect(Customer.top_five_customers.to_a).to eq([@customer, @customer_1, @customer_2, @customer_3, @customer_4])
        binding.pry
        expect(Customer.top_five_customers.to_a).to_not eq([@customer_5])
      end
    end
  end
end
