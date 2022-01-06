require 'rails_helper'

RSpec.describe 'merchant invoice show page', type: :feature do
  let(:merch_1) { create(:merchant) }
  let(:merch_2) { create(:merch_w_all, customer_count: 2) }
  let(:invoice_1) { merch_2.invoices[0] }

  before(:each) { visit merchant_invoice_path(merch_2, merch_2.invoices[0]) }

  describe 'as a merchant' do
    describe 'views elements on the page' do
      it 'displays invoice info, id, status, created date, and customer name' do
        expect(page).to have_content("Invoice ##{invoice_1.id}")
        expect(page).to have_content("Status: #{invoice_1.status}")
        expect(page).to have_content("Created On: #{invoice_1.created_at_formatted}")
        expect(page).to have_content(invoice_1.customer_full_name)
      end
    end
  end
end
