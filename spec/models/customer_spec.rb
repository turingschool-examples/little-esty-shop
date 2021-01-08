require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
  it { should have_many :invoices}
  end

  describe 'validations' do
    it { should validate_presence_of :first_name}
    it { should validate_presence_of :last_name}
  end

  describe 'class methods' do
    it "returns top 5 customers" do
      @merchant = Merchant.create!(name: 'House of thingys')

      @customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe')
      @customer_2 = Customer.create!(first_name: 'Meg', last_name: 'Clain')
      @customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Alves')
      @customer_4 = Customer.create!(first_name: 'Tran', last_name: 'Smith')
      @customer_5 = Customer.create!(first_name: 'Mary', last_name: 'Dumas')
      @customer_6 = Customer.create!(first_name: 'James', last_name: 'Core')

      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, merchant_id: @merchant.id, status: 1)
      @invoice_2 = Invoice.create!(customer_id: @customer_2.id, merchant_id: @merchant.id, status: 1)
      @invoice_3 = Invoice.create!(customer_id: @customer_3.id, merchant_id: @merchant.id, status: 1)
      @invoice_4 = Invoice.create!(customer_id: @customer_4.id, merchant_id: @merchant.id, status: 1)
      @invoice_5 = Invoice.create!(customer_id: @customer_5.id, merchant_id: @merchant.id, status: 1)

      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      @transaction_2 = @invoice_1.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      @transaction_3 = @invoice_2.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      @transaction_4 = @invoice_3.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      @transaction_5 = @invoice_4.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)
      @transaction_6 = @invoice_5.transactions.create!(credit_card_number: "315235234562", credit_card_expiration_date: "05/26/2023", result: 1)

    expect(Customer.top_five).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
    end
  end
end
