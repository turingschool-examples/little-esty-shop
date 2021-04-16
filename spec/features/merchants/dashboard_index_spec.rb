require 'rails_helper'

RSpec.describe 'Merchant DashBoard Index' do
  before :each do
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    Customer.destroy_all

    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant1.id)
    @item5 = create(:item, merchant_id: @merchant1.id)

    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id, created_at: "2019-03-20 09:54:09 UTC")
    @invoice2 = create(:invoice, customer_id: @customer1.id, created_at: "2011-04-25 09:54:09 UTC")
    @invoice3 = create(:invoice, customer_id: @customer1.id, created_at: "2018-08-01 09:54:09 UTC")
    @invoice4 = create(:invoice, customer_id: @customer1.id)

    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id)
    @invoice_items3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice4.id)
    @invoice_items4 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice4.id)

    @customer2 = create(:customer)
    @invoice11 = create(:invoice, customer_id: @customer2.id)
    @invoice12 = create(:invoice, customer_id: @customer2.id)
    @invoice13 = create(:invoice, customer_id: @customer2.id)

    @invoice2 = create(:invoice, customer_id: @customer2.id)
    @invoice_items11 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice11.id)
    @invoice_items12 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice12.id)
    @invoice_items13 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice13.id)

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
          expect(page).to have_link(href: merchant_invoice_path(@merchant1, @invoice_items1.invoice_id))
          expect(page).to have_content(@invoice_items1.invoice.format_time)
      end


      it "shows the list is ordered from oldest to newest" do
        save_and_open_page
      end
    end
  end
end
