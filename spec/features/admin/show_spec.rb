require 'rails_helper'

RSpec.describe 'Admin invoices show page' do
  describe 'When I visit an admin invoice show page' do
    before :each do 
      customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      @invoice = customer.invoices.create!(status: :in_progress)
    end

    it 'I see the invoice ID and status' do
      visit admin_invoice_path(params[:id])
      expect(page).to have_content(@invoice.id)
      expect(page).to have_content(@invoice.status)
    end

    it 'I see the created_at date in the format "Monday, July 18, 2019"'

    it 'I see customer first and last name'
  end
end