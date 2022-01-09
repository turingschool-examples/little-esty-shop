require 'rails_helper'

RSpec.describe 'merchant invoice show page', type: :feature do
  let!(:merch_1) { create(:merchant) }
  let!(:item_1) { create(:item, merchant: merch_1) }
  let!(:item_2) { create(:item, merchant: merch_1) }
  let!(:item_3) { create(:item, merchant: merch_1) }
  let!(:invoice_1) { create(:invoice) }
  let!(:invoice_item_1) { create(:invoice_item, item: item_1, invoice: invoice_1) }
  let!(:invoice_item_2) { create(:invoice_item, item: item_2, invoice: invoice_1) }
  let!(:invoice_item_3) { create(:invoice_item, item: item_3, invoice: invoice_1) }

  let!(:merch_2) { create(:merchant) }
  let!(:item_4) { create(:item, merchant: merch_2) }
  let!(:item_5) { create(:item, merchant: merch_2) }
  let!(:item_6) { create(:item, merchant: merch_2) }
  let!(:invoice_2) { create(:invoice) }
  let!(:invoice_item_4) { create(:invoice_item, item: item_4, invoice: invoice_2) }
  let!(:invoice_item_5) { create(:invoice_item, item: item_5, invoice: invoice_2) }
  let!(:invoice_item_6) { create(:invoice_item, item: item_6, invoice: invoice_2) }
  # let(:merch_2) { create(:merch_w_all, customer_count: 2) }
  # let(:invoice_1) { merch_2.invoices[0] }
  # let(:invoice_2) { merch_2.invoices[1] }
  # let(:invoice_item_1) { merch_2.invoice_items[0] }
  # let(:invoice_item_2) { merch_2.invoice_items[1] }

  before(:each) { visit merchant_invoice_path(merch_1, invoice_1) }

  describe 'as a merchant' do
    describe 'views elements on the page' do
      it 'displays invoice info, id, status, created date, and customer name' do
        expect(page).to have_content("Invoice ##{invoice_1.id}")
        expect(page).to have_content("Status: #{invoice_1.status}")
        expect(page).to have_content("Created On: #{invoice_1.created_at_formatted}")
        expect(page).to have_content(invoice_1.customer_full_name)
      end

      it 'displays invoice items info, name, quantity, and unit price' do
        within("#item-#{item_1.id}") do
          expect(page).to have_content(item_1.name)
          expect(page).to have_content(invoice_item_1.quantity)
          expect(page).to have_content(invoice_item_1.unit_price)
        end

        within("#item-#{item_2.id}") do
          expect(page).to have_content(item_2.name)
          expect(page).to have_content(invoice_item_2.quantity)
          expect(page).to have_content(invoice_item_2.unit_price)
        end

        within("#item-#{item_3.id}") do
          expect(page).to have_content(item_3.name)
          expect(page).to have_content(invoice_item_3.quantity)
          expect(page).to have_content(invoice_item_3.unit_price)
        end
      end

      it 'does not display invoice items from other merchants' do
        within('table') do
          expect(page).to have_no_content(item_4.name)
          expect(page).to have_no_content(invoice_item_4.quantity)
          expect(page).to have_no_content(invoice_item_4.unit_price)

          expect(page).to have_no_content(item_5.name)
          expect(page).to have_no_content(invoice_item_5.quantity)
          expect(page).to have_no_content(invoice_item_5.unit_price)

          expect(page).to have_no_content(item_6.name)
          expect(page).to have_no_content(invoice_item_6.quantity)
          expect(page).to have_no_content(invoice_item_6.unit_price)
        end
      end

      it 'displays total revenue for the invoice' do
        expect(page).to have_content("Total Revenue: #{invoice_1.total_revenue}")
      end

      it 'displays a status dropdown and update button' do
        within("#item-#{item_1.id}") do
          expect(page).to have_select('invoice_item_status', options: ['pending', 'packaged', 'shipped'], selected: 'pending')

          expect(page).to have_button('Update Item Status')
        end

        within("#item-#{item_2.id}") do
          expect(page).to have_select('invoice_item_status', options: ['pending', 'packaged', 'shipped'], selected: 'pending')

          expect(page).to have_button('Update Item Status')
        end

        within("#item-#{item_3.id}") do
          expect(page).to have_select('invoice_item_status', options: ['pending', 'packaged', 'shipped'], selected: 'pending')

          expect(page).to have_button('Update Item Status')
        end
      end
    end

    describe 'clickable elements' do
      it 'updates the invoice items status' do
        within("#item-#{item_1.id}") do
          select('packaged', from: 'invoice_item_status')
          click_button('Update Item Status')

          expect(page).to have_select('invoice_item_status', selected: 'packaged')
        end

        expect(page).to have_current_path(merchant_invoice_path(merch_1, invoice_1))

        within("#item-#{item_2.id}") do
          select('pending', from: 'invoice_item_status')
          click_button('Update Item Status')

          expect(page).to have_select('invoice_item_status', selected: 'pending')
        end

        expect(page).to have_current_path(merchant_invoice_path(merch_1, invoice_1))

        within("#item-#{item_3.id}") do
          select('shipped', from: 'invoice_item_status')
          click_button('Update Item Status')

          expect(page).to have_select('invoice_item_status', selected: 'shipped')
        end

        expect(page).to have_current_path(merchant_invoice_path(merch_1, invoice_1))
    
      end
    end
  end
end
