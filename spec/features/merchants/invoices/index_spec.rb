require 'rails_helper'

RSpec.describe 'merchant invoice index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)
    @item_7 = create(:item, merchant: @merchant_3)
    @item_8 = create(:item, merchant: @merchant_3)
    @item_9 = create(:item, merchant: @merchant_3)
    @item_10 = create(:item, merchant: @merchant_3)

    @invoice_1 = create(:invoice, item: @item_1)
    @invoice_2 = create(:invoice, item: @item_2)
    @invoice_3 = create(:invoice, item: @item_3)
    @invoice_4 = create(:invoice, item: @item_4)
    @invoice_5 = create(:invoice, item: @item_5)
    @invoice_6 = create(:invoice, item: @item_6)
    @invoice_7 = create(:invoice, item: @item_7)
  end

#   As a merchant,
# When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
# Then I see all of the invoices that include at least one of my merchant's items
# And for each invoice I see its id
# And each id links to the merchant invoice show page

  describe '/merchants/merchant_id/invoices' do
    it 'shows all invoices that include at least one of my merchant items' do
      visit merchant_invoices_path(@merchant_1)
      save_and_open_page
    end
  end
end