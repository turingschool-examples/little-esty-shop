require 'rails_helper'

RSpec.describe "merchant invoices index page", type: :feature do
  let(:merch_1) { create(:merchant) }
  let(:merch_2) { create(:merch_w_all, customer_count: 2) }

  before(:each) { visit merchant_invoices_path(merch_2) }

  describe 'as a merchant' do
    describe 'views elements on the page' do
      it 'displays invoices that have atleast one merchant item' do
        expect(page).to have_content(merch_2.invoices[0].id)
        expect(page).to have_content(merch_2.invoices[1].id)
        expect(page).to have_content(merch_2.invoices[2].id)
      end
    end

    describe 'clickable elements' do
      it 'invoices have links to redirect to invoice show page' do
        expect(page).to have_link(merch_2.invoices[0].id.to_s)
        expect(page).to have_link(merch_2.invoices[1].id.to_s)
        expect(page).to have_link(merch_2.invoices[2].id.to_s)
        click_link(merch_2.invoices[0].id.to_s)

        expect(page).to have_current_path(merchant_invoice_path(merch_2, merch_2.invoices[0]))
      end
    end
  end
end
