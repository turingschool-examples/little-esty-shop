require 'rails_helper'

RSpec.describe 'the admin invoices index' do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_3 = create(:invoice, customer: @customer_2)
    @invoice_4 = create(:invoice, customer: @customer_5)
    @invoice_5 = create(:invoice, customer: @customer_5)
  end

  describe 'basics' do
    it 'shows links to all invoices in the db' do
      visit admin_invoices_path

      expect(page).to have_link(@invoice_1.id)
      expect(page).to have_link(@invoice_2.id)
      expect(page).to have_link(@invoice_3.id)
      expect(page).to have_link(@invoice_4.id)
      expect(page).to have_link(@invoice_5.id)
    end
  end
end