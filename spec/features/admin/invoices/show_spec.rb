require 'rails_helper'


RSpec.describe "Admin Invoice Show Page" do

  describe 'As an Admin' do
    before do
      @merchant_1 = create(:merchant)
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_11 = create(:item, merchant_id: @merchant_1.id)
      @item_111 = create(:item, merchant_id: @merchant_1.id)
      @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: 1)
      @invoice_item_11 = create(:invoice_item, item_id: @item_11.id, invoice_id: @invoice_1.id, status: 1)
      @invoice_item_111 = create(:invoice_item, item_id: @item_111.id, invoice_id: @invoice_1.id, status: 1)

      # @customer_2 = create(:customer)
      # @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
      # @item_2 = create(:item, merchant_id: merchant_2.id)
      # @invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, status: 1)

      visit "/admin/invoices/#{@invoice_1.id}"
    end

    it 'lists the item names on the invoice' do
      expect(page).to have_content("#{@item_1.name}")
      expect(page).to have_content("#{@item_11.name}")
      expect(page).to have_content("#{@item_111.name}")
    end
  end
end
