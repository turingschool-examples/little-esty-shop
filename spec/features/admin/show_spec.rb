require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  describe 'When I visit an admin invoice show page' do
    before :each do 
      @customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      @invoice = @customer.invoices.create!(status: 'in progress')
    end

    it 'I see the invoice ID and status' do
      visit admin_invoice_path(@invoice.id)
      expect(page).to have_content(@invoice.id)
      expect(page).to have_content(@invoice.status)
    end

    it 'I see the created_at date in the format "Thursday, July 18, 2019"' do
      allow_any_instance_of(Invoice).to receive(:created_at).and_return(Date.new(2019,7,18))
      invoice = @customer.invoices.create!(status: 'in progress')
      visit admin_invoice_path(invoice.id)
      expect(page).to have_content('Thursday, July 18, 2019')
    end

    it 'I see customer first and last name' do
      visit admin_invoice_path(@invoice.id)
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end
  end
end