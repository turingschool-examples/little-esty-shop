require 'rails_helper'

RSpec.describe Merchant do
  before :each do
    @merchant = Merchant.create!(name: "Frank's Pudding",
                            created_at: Time.parse('2012-03-27 14:53:59 UTC'),
                            updated_at: Time.parse('2012-03-27 14:53:59 UTC'))
    @item_1 = @merchant.items.create!(name: 'Pencil', unit_price: 5, description: 'Writes things.')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @invoice_1 = @customer_1.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_1.transactions.create!(credit_card_number: '4654405418249632', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249631', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249633', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')
    @invoice_1.transactions.create!(credit_card_number: '4654405418249635', result: 'success')

    @customer_2 = Customer.create!(first_name: 'Osinski', last_name: 'Cecelia')
    @invoice_2 = @customer_2.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_2.transactions.create!(credit_card_number: '5654405418249632', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249631', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')
    @invoice_2.transactions.create!(credit_card_number: '5654405418249633', result: 'success')

    @customer_3 = Customer.create!(first_name: 'Toy', last_name: 'Mariah')
    @invoice_3 = @customer_3.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_3.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_3.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')
    @invoice_3.transactions.create!(credit_card_number: '6654405418249631', result: 'success')

    @customer_4 = Customer.create!(first_name: 'Joy', last_name: 'Braun')
    @invoice_4 = @customer_4.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_4.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_4.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_5 = Customer.create!(first_name: 'Mark', last_name: 'Brains')
    @invoice_5 = @customer_5.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_5.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
    @invoice_5.transactions.create!(credit_card_number: '6654405418249632', result: 'success')

    @customer_6 = Customer.create!(first_name: 'Smark', last_name: 'Mrains')
    @invoice_6 = @customer_6.invoices.create!(status: 'completed')
    @item_1.invoice_items.create!(invoice_id: @invoice_6.id, quantity: 3, unit_price: 4, status: 2)
    @invoice_6.transactions.create!(credit_card_number: '6654405418249632', result: 'success')
  end

  context 'readable attributes' do
    it 'has a name' do
      expect(@merchant.name).to eq("Frank's Pudding")
    end
  end

  context 'validations' do
    it { should validate_presence_of :name }
  end

  context 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  context 'instance methods' do
    it '.top_five_customers returns best customers based on transactions' do
      expect(@merchant.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
    end

    it 'can return the top five items revenue' do

      item_2 = @merchant.items.create!(name: 'Eraser', unit_price: 2, description: 'Does things.')
      item_3 = @merchant.items.create!(name: 'Pen', unit_price: 3, description: 'Helps things.')
      item_4 = @merchant.items.create!(name: 'Calculator', unit_price: 4, description: 'Considers things.')
      item_5 = @merchant.items.create!(name: 'Stapler', unit_price: 5, description: 'Wishes things.')
      item_6 = @merchant.items.create!(name: 'Computer', unit_price: 6, description: 'Hopes things.')
      item_7 = @merchant.items.create!(name: 'Backpack', unit_price: 7, description: 'Forgets things.')
      item_2.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 2, unit_price: 5, status: 2)
      item_3.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 3, unit_price: 6, status: 2)
      item_4.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 4, unit_price: 7, status: 2)
      item_5.invoice_items.create!(invoice_id: @invoice_1.id, quantity: 5, unit_price: 8, status: 2)

      item_3.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 1, unit_price: 4, status: 2)
      item_4.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 2, unit_price: 5, status: 2)
      item_5.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 3, unit_price: 6, status: 2)
      item_6.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 4, unit_price: 7, status: 2)
      item_7.invoice_items.create!(invoice_id: @invoice_2.id, quantity: 5, unit_price: 8, status: 2)

      expect(@merchant.top_five_items_by_revenue).to eq([item_5, @item_1, item_4, item_7, item_6])
    end
  end
end
