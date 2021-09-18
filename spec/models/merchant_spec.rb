require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items).dependent(:destroy) }
  end

  describe '#instance methods' do
    before(:each) do
      @merchant = create(:merchant)
      @merchant_2 = create(:merchant, name: "Jennys Jewels", status: 'Enabled')
      @disabled_item_1 = create(:item, merchant: @merchant)
      @disabled_item_2 = create(:item, merchant: @merchant)
      @enabled_item_1  = create(:item, merchant: @merchant, status: 'Enabled')
      @enabled_item_2  = create(:item, merchant: @merchant, status: 'Enabled')
    end

    describe 'enabled and disabled items' do
      it 'returns the merchants enabled items' do
        expect(@merchant.enabled_items).to eq([@enabled_item_1, @enabled_item_2])
      end

      it 'returns the merchants disabled items' do
        expect(@merchant.disabled_items).to eq([@disabled_item_1, @disabled_item_2])
      end
    end

    describe 'disabled?' do
      it 'returns true is disabled' do
        expect(@merchant.disabled?).to eq(true)
        expect(@merchant_2.disabled?).to eq(false)
      end
    end

    describe 'update_status' do
      it 'updates merchant status' do
        @merchant_2.update_status('Disabled')
        expect(@merchant_2.status).to eq('Disabled')
        @merchant.update_status('Enabled')
        expect(@merchant.status).to eq('Enabled')
      end
    end
  end

  describe '#class methods' do
    before(:each) do
      @merchant = create(:merchant)
      @merchant_2 = create(:merchant, name: "Jennys Jewels", status: 'Enabled')
      @disabled_item_1 = create(:item, merchant: @merchant)
      @disabled_item_2 = create(:item, merchant: @merchant)
      @enabled_item_1  = create(:item, merchant: @merchant, status: 'Enabled')
      @enabled_item_2  = create(:item, merchant: @merchant, status: 'Enabled')
    end

    it '#enabled_merchants' do
      expect(Merchant.enabled_merchants).to eq([@merchant_2])
    end

    it '#disabled_merchants' do
      expect(Merchant.disabled_merchants).to eq([@merchant])
    end
  end

  describe '#favorite_customers' do
    before(:each) do
      @merchant = create(:merchant)
      @item     = create(:item, merchant_id: @merchant.id)

      # 5 successes
      @customer_2    = create(:customer)
      @invoice_2     = create(:invoice, customer_id: @customer_2.id)
      @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_2.id)
      @transaction_8 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')
      @transaction_9 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')
      @transaction_10 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')
      @transaction_11 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')
      @transaction_12 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')

      # 4 successes
      @customer_3    = create(:customer)
      @invoice_3     = create(:invoice, customer_id: @customer_3.id)
      @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_3.id)
      @transaction_13 = create(:transaction, invoice_id: @invoice_3.id, result: 'success')
      @transaction_14 = create(:transaction, invoice_id: @invoice_3.id, result: 'success')
      @transaction_15 = create(:transaction, invoice_id: @invoice_3.id, result: 'success')
      @transaction_16 = create(:transaction, invoice_id: @invoice_3.id, result: 'success')

      # 3 successes
      @customer_4    = create(:customer)
      @invoice_4     = create(:invoice, customer_id: @customer_4.id)
      @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_4.id)
      @transaction_17 = create(:transaction, invoice_id: @invoice_4.id, result: 'success')
      @transaction_18 = create(:transaction, invoice_id: @invoice_4.id, result: 'success')
      @transaction_19 = create(:transaction, invoice_id: @invoice_4.id, result: 'success')

      # 2 successes
      @customer_5    = create(:customer)
      @invoice_5     = create(:invoice, customer_id: @customer_5.id)
      @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_5.id)
      @transaction_20 = create(:transaction, invoice_id: @invoice_5.id, result: 'success')
      @transaction_21 = create(:transaction, invoice_id: @invoice_5.id, result: 'success')

      @customer_6    = create(:customer, first_name: 'Jill')
      @invoice_6     = create(:invoice, customer_id: @customer_6.id)
      @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_6.id)
      @transaction_1 = create(:transaction, invoice_id: @invoice_6.id, result: 'success')

      @customer_1    = create(:customer)
      @invoice_1     = create(:invoice, customer_id: @customer_1.id)
      @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoice_1.id)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_2 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_3 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_4 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_5 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_6 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')

      # failed
      @transaction_7 = create(:transaction, invoice_id: @invoice_1.id)
    end

    it 'gives the top five for the merchant' do
      expect(@merchant.favorite_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
    end
  end
end
