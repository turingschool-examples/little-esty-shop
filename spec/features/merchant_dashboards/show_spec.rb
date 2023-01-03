require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_3 = create(:invoice, customer: @customer_2)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_4)
    
    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
    @transaction_4 = create(:transaction, invoice: @invoice_4)
    @transaction_5 = create(:transaction, invoice: @invoice_5)

    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_3)
    @item_6 = create(:item, merchant: @merchant_1)
    @item_7 = create(:item, merchant: @merchant_1)
    @item_8 = create(:item, merchant: @merchant_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1 )
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_1 )
    @invoice_item_3 = create(:invoice_item, item: @item_2, invoice: @invoice_1 )
    @invoice_item_4 = create(:invoice_item, item: @item_5, invoice: @invoice_2 )
    @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_2 )
    @invoice_item_6 = create(:invoice_item, item: @item_3, invoice: @invoice_3 )
    @invoice_item_7 = create(:invoice_item, item: @item_4, invoice: @invoice_3 )
    @invoice_item_8 = create(:invoice_item, item: @item_8, invoice: @invoice_3 )
    @invoice_item_9 = create(:invoice_item, item: @item_3, invoice: @invoice_4 )
    @invoice_item_10 = create(:invoice_item, item: @item_6, invoice: @invoice_5 )
    @invoice_item_11 = create(:invoice_item, item: @item_7, invoice: @invoice_5 )
  end

  describe 'Story 1 - merchant dashboard Page' do
    it 'displays the name of name of my merchant' do
      visit merchants_merchantid_dashboard_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
    end
  end
end