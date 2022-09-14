require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do

    it {should have_many(:items)}

    describe 'instance variables' do

      before(:each) do
        @merchant_1 = create(:merchant)
        @item_1 = create(:item, merchant: @merchant_1)
        @item_2 = create(:item, merchant: @merchant_1)
        @invoice_1 = create(:invoice)
        @invoice_2 = create(:invoice)
        @invoice_3 = create(:invoice)
        @invoice_4 = create(:invoice)
        @invoice_1.items << [@item_1, @item_2]
        @invoice_3.items << @item_1
        @invoice_4.items << @item_2
      end

      describe '.invoices' do
        it 'returns a list of invoices which contain an item from the merchant' do
          expect(@merchant_1.invoices).to eq([@invoice_1, @invoice_3, @invoice_4])
        end
      end
    end

  end
end
