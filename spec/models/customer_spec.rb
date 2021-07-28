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
      @customer_1 = Customer.create!(first_name: 'Tuco', last_name: 'Salamanca')
      @customer_1.invoices.create!(status: 2)
      @customer_1.invoices[0].transactions.create!(credit_card_number: '123', credit_card_expiration_date: '', result: 0)
      @customer_1.invoices.create!(status: 2)
      @customer_2 = Customer.create!(first_name: 'Hector', last_name: 'Salamanca')
      @customer_2.invoices.create!(status: 2)
      @customer_2.invoices.create!(status: 2)
      @customer_2.invoices.create!(status: 2)
      @customer_3 = Customer.create!(first_name: 'Gustavo', last_name: 'Fring')
      @customer_3.invoices.create!(status: 2)
      @customer_3.invoices.create!(status: 2)
      @customer_4 = Customer.create!(first_name: 'Jesse', last_name: 'Pinkman')
      @customer_4.invoices.create!(status: 2)
      @customer_5 = Customer.create!(first_name: 'Walter', last_name: 'White')
      @customer_5.invoices.create!(status: 2)
      @customer_5.invoices.create!(status: 2)
      @customer_5.invoices.create!(status: 2)
      @customer_6 = Customer.create!(first_name: 'Jack', last_name: 'Welker')
      @customer_7 = Customer.create!(first_name: 'Todd', last_name: 'Alquist')

    end

    it 'can return top 5 customers for a given merchant' do
      transaction_1 =
    end
  end

end
