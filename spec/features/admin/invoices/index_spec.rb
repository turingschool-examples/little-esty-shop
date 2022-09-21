require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do
  before :each do
    names_array = {'gjcarew' => 22, 'stephenfabian' => 25, 'Rileybmcc' => 22, 'KevinT001' => 11}
    allow(GithubFacade).to receive(:commits).and_return(names_array)

    pull_requests_count = 3
    allow(GithubFacade).to receive(:pull_requests).and_return(pull_requests_count)
  end
  describe 'When I visit the admin Invoices index' do
    before :each do
      customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      @invoice_1 = customer.invoices.create!(status: 'in progress')
      @invoice_2 = customer.invoices.create!(status: 'completed')
      @invoice_3 = customer.invoices.create!(status: 'cancelled')
    end

    it 'I see a list of all invoice ids in the system' do
      visit admin_invoices_path
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
    end

    it 'Each id links to the admin invoice show page' do
      visit admin_invoices_path
      click_link "Invoice ##{@invoice_1.id}"
      expect(current_path).to eq(admin_invoice_path(@invoice_1))
      visit admin_invoices_path
      click_link "Invoice ##{@invoice_2.id}"
      expect(current_path).to eq(admin_invoice_path(@invoice_2))
      visit admin_invoices_path
      click_link "Invoice ##{@invoice_3.id}"
      expect(current_path).to eq(admin_invoice_path(@invoice_3))
    end
  end
end