require 'rails_helper'

RSpec.describe 'the admin invoices show page' do
  describe 'as an admin' do
    before :each do
      @customer = Customer.create!(first_name: 'Taylor', last_name: 'Swift')
      @invoice = @customer.invoices.create!(status: 'in progress')
    end

    it 'displays information related to the invoice' do
      visit "/admin/invoices/#{@invoice.id}"

      expect(page).to have_content @invoice.id
      expect(page).to have_content @invoice.status
      expect(page).to have_content @invoice.created_at.strftime("%A, %B %-d, %Y")
    end

    it 'also displays the first and last name of the customer' do
      visit "/admin/invoices/#{@invoice.id}"

      expect(page).to have_content @customer.first_name
      expect(page).to have_content @customer.last_name
    end
  end
end
