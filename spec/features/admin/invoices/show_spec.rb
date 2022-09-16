# Admin Invoice Show Page

# As an admin,
# When I visit an admin invoice show page
# Then I see information related to that invoice including:
# - Invoice id
# - Invoice status
# - Invoice created_at date in the format "Monday, July 18, 2019"
# - Customer first and last name
require 'rails_helper'

describe 'the admin invoices show page' do
  describe 'When I visit an admin invoice show page' do
    it 'I see invoice id/status/created_at/customer full name' do
      customer_1 = create(:random_customer)
      customer_2 = create(:random_customer)

      invoice_1 = create(:random_invoice, customer: Customer.all[0])
      invoice_2 = create(:random_invoice, customer: Customer.all[1])

      visit admin_invoice_path(invoice_1)

      expect(page).to have_content(invoice_2.id)
      expect(page).to have_content(invoice_2.status)
      expect(page).to have_content(invoice_2.created_at.strftime('%A, %B %d, %Y'))
      expect(page).to have_content(customer_1.first_name)
      expect(page).to have_content(customer_1.last_name)
      expect(page).to_not have_content(invoice_2.id)
    end
  end
end