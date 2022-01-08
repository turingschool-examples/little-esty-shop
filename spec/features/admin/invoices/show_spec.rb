require 'rails_helper'

RSpec.describe 'Admin Invoices Show' do
  describe 'view' do

    it 'I see information related to that invoice' do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@invoice_1.customer.first_name)
      expect(page).to have_content(@invoice_1.customer.last_name)
    end
  end
end
