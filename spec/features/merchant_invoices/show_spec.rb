require 'rails_helper'

RSpec.describe 'the merchant invoice show' do

  describe 'display' do
    it 'shows header text merchant name and invoice id' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within('#header') do
        expect(page).to have_content(@merchant1.name)
        expect(page).to have_content("Invoice ##{@invoice1.id}")
      end
    end

    it 'shows status, created on, and total revenue' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within('#invoice_info') do
        expect(page).to have_content("Status: #{@invoice1.status}")
        expect(page).to have_content("Created on: #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
      end
    end

    it 'shows customer header and name' do
      visit merchant_invoice_path(@merchant1.id, @invoice1.id)

      within('#customer') do
        expect(page).to have_content("Customer:")
        expect(page).to have_content("#{@invoice1.customer.first_name} #{@invoice1.customer.last_name}")
      end
    end
  end
end
