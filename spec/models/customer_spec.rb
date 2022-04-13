require 'rails_helper'

RSpec.describe Customer do
  before :each do
    @merchant = Merchant.create!(name: 'Brylan')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed')
    @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 5, description: 'Writes things.')
    @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 2)
    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
    @transaction_3 = @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
    @transaction_4 = @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'failed')
    @transaction_5 = @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'failed')
    @transaction_6 = @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'failed')
  end

  context 'readable attributes' do
    it 'has a name' do
      expect(@customer_1.first_name).to eq("Joey")
      expect(@customer_1.last_name).to eq("Ondricka")
    end
  end

  context 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  context 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end

  context 'instance methods' do
    it '.successful_transactions should return all successful transactions' do
      expect(@customer_1.successful_transactions).to eq([@transaction_1, @transaction_2, @transaction_3])
    end
  end
end
