require 'rails_helper'

RSpec.describe 'invoices index page', type: :feature do
  before(:each) do
    @jack_daniels = Customer.create!(first_name: "Jack", last_name: "Daniels")
    @isabella = Customer.create!(first_name: "Isabella", last_name: "Cocoran")
    @invoice1 = @jack_daniels.invoices.create!(status: "Pending") # will need to implement enum in invoice model
    @invoice2 = @jack_daniels.invoices.create!(status: "Pending") # will need to implement enum in invoice model
    @invoice3 = @isabella.invoices.create!(status: "Pending") # will need to implement enum in invoice model
    @invoice4 = @isabella.invoices.create!(status: "Pending") # will need to implement enum in invoice model
  end

  describe 'page appearance' do
    it 'has links to every invoice' do
      visit '/admin/invoices'

      expect(page).to have_link "invoice-#{@invoice1.id}"
      expect(page).to have_link "invoice-#{@invoice2.id}"
      expect(page).to have_link "invoice-#{@invoice3.id}"
      expect(page).to have_link "invoice-#{@invoice4.id}"
      click_link "invoice-#{@invoice4.id}"
      expect(current_path).to eq "/admin/invoices/#{@invoice4.id}"
    end
  end

  describe 'page functionality' do
  end
end
