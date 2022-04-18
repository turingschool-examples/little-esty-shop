require 'rails_helper'


RSpec.describe 'Admin Invoice Show' do
  describe 'Admin Invoice Show Page' do
    it 'lists Invoice id, status, created at and customer name' do
      customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
      invoice_1 = customer.invoices.create(status: "in progress")

      visit "/admin/invoices"

      click_link "#{invoice_1.id}"
      expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
      expect(page).to have_content("#{invoice_1.id}")
      expect(page).to have_content("#{invoice_1.status}")
      expect(page).to have_content("#{invoice_1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Billy Jonson")

    end

    it 'lists a link to update Invoice status using a select field' do
      customer = Customer.create!(first_name: "Billy", last_name: "Jonson")
      invoice_1 = customer.invoices.create(status: "in progress")

      visit "/admin/invoices/#{invoice_1.id}"

      select "cancelled" , from: :status
      click_button 'Change Status'
      expect(current_path).to eq("/admin/invoices/#{invoice_1.id}")
      expect(page).to have_content('cancelled')

    end
  end
end
