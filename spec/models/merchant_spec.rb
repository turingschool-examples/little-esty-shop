require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'model methods' do
    before(:each) do
      @merchant = create(:merchant)
      @merchant1 = create(:merchant, status: 'enabled')

      @customer1 = create :customer
      @customer2 = create :customer
      @customer3 = create :customer
      @customer4 = create :customer
      @customer5 = create :customer
      @customer6 = create :customer

      @item = create :item, { merchant_id: @merchant.id }

      @invoice1 = create :invoice, { customer_id: @customer1.id }
      @invoice2 = create :invoice, { customer_id: @customer2.id }
      @invoice3 = create :invoice, { customer_id: @customer3.id }
      @invoice4 = create :invoice, { customer_id: @customer4.id }
      @invoice5 = create :invoice, { customer_id: @customer5.id }
      @invoice6 = create :invoice, { customer_id: @customer6.id }

      @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
      @transaction2 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
      @transaction3 = create :transaction, { invoice_id: @invoice3.id, result: 'success' }
      @transaction4 = create :transaction, { invoice_id: @invoice4.id, result: 'success' }
      @transaction5 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
      @transaction6 = create :transaction, { invoice_id: @invoice6.id, result: 'failed' }

      @inv_item1 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice1.id}
      @inv_item2 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice2.id}
      @inv_item3 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice3.id}
      @inv_item4 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice4.id}
      @inv_item5 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice5.id}
      @inv_item6 = create :invoice_item, { item_id: @item.id, invoice_id: @invoice6.id}
    end
    describe 'favorite customers' do
      it 'returns top 5 customers by successful transactions' do
        expect(@merchant.favorite_customers).to include(@customer1.id, @customer2.id, @customer3.id, @customer4.id, @customer5.id)
      end
    end

    describe 'merchant_invoices' do
      it 'returns invoices for a the merchant' do
        expect(@merchant.merchant_invoices).to eq([@invoice1,@invoice2,@invoice3,@invoice4,@invoice5,@invoice6])
      end
    end

    it 'identifies status' do
      expect(Merchant.merchant_status('disabled')).to include(@merchant)
      expect(Merchant.merchant_status('enabled')).to eq([@merchant1])
    end
  end

  describe 'instance methods' do
    before(:each) do
      @merchant = create(:merchant)
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)
      @merchant4 = create(:merchant)

      @customer1 = create :customer
      @customer2 = create :customer

      @customer3 = create :customer
      @customer4 = create :customer

      @item1 = create :item, { merchant_id: @merchant.id }
      @item2 = create :item, { merchant_id: @merchant.id }
      @item3 = create :item, { merchant_id: @merchant.id }
      @item4 = create :item, { merchant_id: @merchant.id }
      @item5 = create :item, { merchant_id: @merchant.id }
      @item6 = create :item, { merchant_id: @merchant.id }

      @item7 = create :item, { merchant_id: @merchant1.id }
      @item8 = create :item, { merchant_id: @merchant1.id }
      @item9 = create :item, { merchant_id: @merchant2.id }
      @item10 = create :item, { merchant_id: @merchant3.id }
      @item11 = create :item, { merchant_id: @merchant4.id }


      @invoice1 = create :invoice, { customer_id: @customer1.id, created_at: DateTime.new(2021, 1, 1) }
      @invoice2 = create :invoice, { customer_id: @customer2.id, created_at: DateTime.new(2021, 1, 1) }
      @invoice3 = create :invoice, { customer_id: @customer2.id, created_at: DateTime.new(2021, 1, 1) }
      @invoice4 = create :invoice, { customer_id: @customer2.id, created_at: DateTime.new(2021, 1, 1) }
      @invoice5 = create :invoice, { customer_id: @customer2.id, created_at: DateTime.new(2021, 1, 2) }
      @invoice6 = create :invoice, { customer_id: @customer2.id, created_at: DateTime.new(2021, 1, 3) }
      @invoice7 = create :invoice, { customer_id: @customer2.id, created_at: DateTime.new(2021, 1, 4) }

      @invoice8 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 5) }
      @invoice9 = create :invoice, { customer_id: @customer3.id, created_at: DateTime.new(2021, 1, 6) }
      @invoice10 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }
      @invoice11 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }
      @invoice12 = create :invoice, { customer_id: @customer4.id, created_at: DateTime.new(2021, 1, 6) }

      @transaction1 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
      @transaction2 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
      @transaction3 = create :transaction, { invoice_id: @invoice1.id, result: 'success' }
      @transaction4 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
      @transaction5 = create :transaction, { invoice_id: @invoice2.id, result: 'success' }
      @transaction6 = create :transaction, { invoice_id: @invoice3.id, result: 'failed' }
      @transaction7 = create :transaction, { invoice_id: @invoice4.id, result: 'failed' }
      @transaction8 = create :transaction, { invoice_id: @invoice5.id, result: 'success' }
      @transaction9 = create :transaction, { invoice_id: @invoice6.id, result: 'success' }
      @transaction10 = create :transaction, { invoice_id: @invoice7.id, result: 'success' }

      @transaction11 = create :transaction, { invoice_id: @invoice8.id, result: 'success' }
      @transaction12 = create :transaction, { invoice_id: @invoice9.id, result: 'success' }
      @transaction13 = create :transaction, { invoice_id: @invoice10.id, result: 'success' }
      @transaction14 = create :transaction, { invoice_id: @invoice11.id, result: 'success' }
      @transaction15 = create :transaction, { invoice_id: @invoice12.id, result: 'success' }

      @inv_item1 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice1.id, unit_price: 10000, quantity: 1}
      @inv_item2 = create :invoice_item, { item_id: @item2.id, invoice_id: @invoice1.id, unit_price: 9000, quantity: 1}
      @inv_item3 = create :invoice_item, { item_id: @item3.id, invoice_id: @invoice2.id, unit_price: 8000, quantity: 1}
      @inv_item4 = create :invoice_item, { item_id: @item4.id, invoice_id: @invoice2.id, unit_price: 7000, quantity: 1}
      @inv_item5 = create :invoice_item, { item_id: @item5.id, invoice_id: @invoice2.id, unit_price: 6000, quantity: 1}
      @inv_item6 = create :invoice_item, { item_id: @item6.id, invoice_id: @invoice3.id, unit_price: 10000000, quantity: 1}
      @inv_item7 = create :invoice_item, { item_id: @item6.id, invoice_id: @invoice4.id, unit_price: 10000000, quantity: 1}
      @inv_item8 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice5.id, unit_price: 10000, quantity: 2}
      @inv_item9 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice6.id, unit_price: 10000, quantity: 3}
      @inv_item10 = create :invoice_item, { item_id: @item1.id, invoice_id: @invoice7.id, unit_price: 10000, quantity: 4}

      @inv_item11 = create :invoice_item, { item_id: @item7.id, invoice_id: @invoice8.id, unit_price: 10000, quantity: 4}
      @inv_item12 = create :invoice_item, { item_id: @item8.id, invoice_id: @invoice9.id, unit_price: 3000, quantity: 6}
      @inv_item13 = create :invoice_item, { item_id: @item9.id, invoice_id: @invoice10.id, unit_price: 300, quantity: 30}
      @inv_item14 = create :invoice_item, { item_id: @item10.id, invoice_id: @invoice11.id, unit_price: 45, quantity: 3000}
      @inv_item15 = create :invoice_item, { item_id: @item11.id, invoice_id: @invoice12.id, unit_price: 1200, quantity: 7}
    end

    describe '#top_five_items' do
      it 'returns the top five items by total revenue' do
      expect(@merchant.top_five_items).to eq([@item1,@item2,@item3,@item4,@item5])
      end
    end

    it 'lists top 5 merchants by revenue' do
      expect(Merchant.top_five_merchants).to eq([@merchant, @merchant3, @merchant1, @merchant2, @merchant4])
    end 
    
    ###  TECHNICAL DEBT: this needs to be moved to item model test along with set-up. Or does it? Let's discuss.
    describe '#item_best_day' do
      it 'returns the date of the greatest number of sales for items' do
        expect(@merchant.top_five_items.first.item_best_day).to eq(DateTime.new(2021, 1, 4))
      end
    end

    it 'identifies status' do
      @merchant = create(:merchant)
      @merchant1 = create(:merchant, status: "enabled")

      expect(Merchant.merchant_status('disabled')).to eq([@merchant])
      expect(Merchant.merchant_status('enabled')).to eq([@merchant1])

    end

    it 'shows merchant best day' do
      expect(Merchant.merchant_best_day).to eq(@invoice9.created_at.to_date)
    end
  end
end
