require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :discounts }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  before :each do
    load_test_data1
  end
  
  describe 'instance_methods' do


    describe '#top_five_customers' do
      it 'can return top 5 customers with most transactions' do
          expect(@merchant_1.top_five_customers).to eq([@customer_8, @customer_2, @customer_5, @customer_1, @customer_3])
          expect(@merchant_1.top_five_customers.length).to eq(5)
      end
    end
    
    describe 'items_ready_to_ship' do
      it 'will list all the items ready to ship' do
        expect(@merchant_1.items_ready_to_ship).to eq([@ii_1, @ii_3, @ii_7, @ii_9, @ii_14])
      end
    end

    describe '#change_status' do
      it 'changes an items status' do
        expect(@merchant_1.status).to eq('disabled')
        
        @merchant_1.change_status
        
        expect(@merchant_1.status).to eq('enabled')

        @merchant_1.change_status
        
        expect(@merchant_1.status).to eq('disabled')
      end
    end

    describe '#top_selling_date' do
      it ' returns the date where the merchant had the best sales' do
        expect(@merchant_1.top_selling_date).to eq("2010-01-01 00:00:00 UTC")
      end
    end
  end


  describe 'Class Methods' do
    it 'returns the top 5 merchants' do
      expect(Merchant.top_five_merchants).to eq([@merchant_1, @merchant_4, @merchant_2, @merchant_6, @merchant_3])
      expect(Merchant.top_five_merchants).to_not include(@merchant_5)
    end
  end

  describe '#top_five_most_popular_items' do
    it 'will list the top five items based on total revenue generated' do
      expect(@merchant_1.top_five_items_by_revenue).to eq([@item_1, @item_11, @item_9, @item_10, @item_8])
    end
  end
end