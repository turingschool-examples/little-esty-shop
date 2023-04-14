require 'rails_helper'

RSpec.describe 'admin_dashboard', type: :feature do
  describe 'As an admin, when I visit the admin dashboard' do
    before(:each) do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)
      @customer_7 = create(:customer)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id)
      @invoice_4 = create(:invoice, customer_id: @customer_4.id)
      @invoice_5 = create(:invoice, customer_id: @customer_5.id)
      @invoice_6 = create(:invoice, customer_id: @customer_6.id)
      @invoice_7 = create(:invoice, customer_id: @customer_7.id)

      create(:transaction, result: 'success', invoice_id: @invoice_1.id)
      create(:transaction, result: 'success', invoice_id: @invoice_1.id)
      create(:transaction, result: 'success', invoice_id: @invoice_1.id)
      create(:transaction, result: 'success', invoice_id: @invoice_2.id)
      create(:transaction, result: 'success', invoice_id: @invoice_2.id)
      create(:transaction, result: 'success', invoice_id: @invoice_2.id)
      create(:transaction, result: 'success', invoice_id: @invoice_2.id)
      create(:transaction, result: 'success', invoice_id: @invoice_3.id)
      create(:transaction, result: 'success', invoice_id: @invoice_3.id)
      create(:transaction, result: 'success', invoice_id: @invoice_3.id)
      create(:transaction, result: 'success', invoice_id: @invoice_3.id)
      create(:transaction, result: 'success', invoice_id: @invoice_3.id)
      create(:transaction, result: 'success', invoice_id: @invoice_4.id)
      create(:transaction, result: 'success', invoice_id: @invoice_4.id)
      create(:transaction, result: 'success', invoice_id: @invoice_4.id)
      create(:transaction, result: 'success', invoice_id: @invoice_4.id)
      create(:transaction, result: 'success', invoice_id: @invoice_4.id)
      create(:transaction, result: 'success', invoice_id: @invoice_4.id)
      create(:transaction, result: 'success', invoice_id: @invoice_5.id)
      create(:transaction, result: 'success', invoice_id: @invoice_5.id)
      create(:transaction, result: 'success', invoice_id: @invoice_5.id)
      create(:transaction, result: 'success', invoice_id: @invoice_5.id)
      create(:transaction, result: 'success', invoice_id: @invoice_5.id)
      create(:transaction, result: 'success', invoice_id: @invoice_5.id)
      create(:transaction, result: 'success', invoice_id: @invoice_5.id)
      create(:transaction, result: 'failed', invoice_id: @invoice_5.id)
      create(:transaction, result: 'success', invoice_id: @invoice_7.id)
      create(:transaction, result: 'success', invoice_id: @invoice_7.id)
      create(:transaction, result: 'failed', invoice_id: @invoice_7.id)
      create(:transaction, result: 'failed', invoice_id: @invoice_7.id)
      create(:transaction, result: 'failed', invoice_id: @invoice_7.id)
      create(:transaction, result: 'failed', invoice_id: @invoice_7.id)
      create(:transaction, result: 'failed', invoice_id: @invoice_7.id)
    end

    it 'displays a header indicating that I am on the admin dashboard' do
      visit '/admin'
      expect(page).to have_content('Admin Dashboard')
    end

    it 'has invoices and merchants index links' do
      visit '/admin'
      expect(page).to have_link('Admin Merchants')
      expect(page).to have_link('Admin Invoices')
    end
  end
end