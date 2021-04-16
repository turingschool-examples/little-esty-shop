require 'rails_helper'

RSpec.describe 'Merchant DashBoard Index' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)

    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2019-03-20 09:54:09 UTC")
    @invoice2 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2011-04-25 09:54:09 UTC")
    @invoice3 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2018-08-01 09:54:09 UTC")
    @invoice4 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2020-07-01 09:54:09 UTC")

    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 1)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
    @invoice_items4 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice4.id, status: 1)

    visit merchant_dashboard_index_path(@merchant1)
  end

  describe 'As a merchant,' do
    describe 'When I visit my merchant dashboard (/merchant/merchant_id/dashboard)' do
      it 'shows the name of my merchant' do

        expect(page).to have_content(@merchant1.name)
      end

      it 'Shows a link to my merchant items index' do
        within(".navbar") do
          expect(page).to have_link('My Items')
          click_link('My Items')
          expect(current_path).to eq(merchant_items_path(@merchant1))
        end
      end

      it 'Shows a link to my invoice index' do
        within(".navbar") do
          expect(page).to have_link('My Invoices')
          click_link('My Invoices')
          expect(current_path).to eq(merchant_invoices_path(@merchant1))
        end
      end

      it 'I see a section for "Items Ready to Ship"' do
        within '.items-to-ship' do
          expect(page).to have_content("Items Ready to Ship")
        end
      end

      it 'Shows a list of the link names that have not been shipped, and date, that route to merchant show page' do
          expect(page).to have_link("Invoice ##{@invoice1.id}")
          expect(page).to have_content(@invoice1.format_time)
      end

      it "shows the list is ordered from oldest to newest" do
        expect(@invoice2.format_time).to appear_before(@invoice1.format_time)
      end
    end
  end
end
