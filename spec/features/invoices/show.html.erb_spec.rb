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

      it 'displays invoice items info, name, quantity, unit price, and status' do
        within("#item-#{item_1.id}") do
          expect(page).to have_content(item_1.name)
          expect(page).to have_content(invoice_item_1.quantity)
          expect(page).to have_content(invoice_item_1.unit_price)
          expect(page).to have_content(invoice_item_1.status)
        end

        within("#item-#{item_2.id}") do
          expect(page).to have_content(item_2.name)
          expect(page).to have_content(invoice_item_2.quantity)
          expect(page).to have_content(invoice_item_2.unit_price)
          expect(page).to have_content(invoice_item_2.status)
        end

        within("#item-#{item_3.id}") do
          expect(page).to have_content(item_3.name)
          expect(page).to have_content(invoice_item_3.quantity)
          expect(page).to have_content(invoice_item_3.unit_price)
          expect(page).to have_content(invoice_item_3.status)
        end
      end
    end
  end
end
