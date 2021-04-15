require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
  end

  before(:each) do
    @merchant_1 = FactoryBot.create(:merchant)

    @item_1 = FactoryBot.create(:item)
    @item_2 = FactoryBot.create(:item)
    @item_3 = FactoryBot.create(:item)
    @item_4 = FactoryBot.create(:item)
    @item_5 = FactoryBot.create(:item)

    @merchant_1.items << [@item_1, @item_2, @item_3, @item_4, @item_5]

    @customer_1 = FactoryBot.create(:customer)
    @customer_2 = FactoryBot.create(:customer)
    @customer_3 = FactoryBot.create(:customer)
    @customer_4 = FactoryBot.create(:customer)
    @customer_5 = FactoryBot.create(:customer)
    @customer_6 = FactoryBot.create(:customer)

    @invoice_1 = FactoryBot.create(:invoice)
    @invoice_2 = FactoryBot.create(:invoice)
    @invoice_3 = FactoryBot.create(:invoice)
    @invoice_4 = FactoryBot.create(:invoice)
    @invoice_5 = FactoryBot.create(:invoice)

    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2)
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_3)
    @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, invoice: @invoice_4)
    @invoice_item_5 = FactoryBot.create(:invoice_item, item: @item_5, invoice: @invoice_5)


    @transaction_1 = FactoryBot.create(:transaction)
    @transaction_2 = FactoryBot.create(:transaction)
    @transaction_3 = FactoryBot.create(:transaction)
    @transaction_4 = FactoryBot.create(:transaction)
    @transaction_5 = FactoryBot.create(:transaction)
    @invoice_1.transactions << [@transaction_1, @transaction_2, @transaction_3, @transaction_4, @transaction_5]

    @transaction_6 = FactoryBot.create(:transaction)
    @transaction_7 = FactoryBot.create(:transaction)
    @transaction_8 = FactoryBot.create(:transaction)
    @transaction_9 = FactoryBot.create(:transaction)
    @invoice_2.transactions << [@transaction_6, @transaction_7, @transaction_8, @transaction_9]

    @transaction_10 = FactoryBot.create(:transaction)
    @transaction_11 = FactoryBot.create(:transaction)
    @transaction_12 = FactoryBot.create(:transaction)
    @invoice_3.transactions << [@transaction_10, @transaction_11, @transaction_12]

    @transaction_13 = FactoryBot.create(:transaction)
    @transaction_14 = FactoryBot.create(:transaction)
    @invoice_4.transactions << [@transaction_13, @transaction_14]

    @transaction_15 = FactoryBot.create(:transaction)
    @invoice_5.transactions << [@transaction_15]

    @invoice_item_1 = FactoryBot.create(:invoice_item)
    @invoice_item_2 = FactoryBot.create(:invoice_item)
    require "pry"; binding.pry
  end
end
