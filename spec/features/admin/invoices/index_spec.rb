require 'rails_helper'

RSpec.describe 'admin invoices index page', type: :feature do
  it 'has of list of all invoice ids as links to their show pages' do
    customer = Customer.create!(first_name: "A", last_name: "AA")
    invoice1 = customer.invoices.create!(status: 0)
    invoice2 = customer.invoices.create!(status: 1)
    invoice3 = customer.invoices.create!(status: 2)
    
    visit '/admin/invoices'
    
    within("#invoice-#{invoice1.id}") do
      expect(page).to have_link(invoice1.id)
    end
    
    within("#invoice-#{invoice2.id}") do
      expect(page).to have_link(invoice2.id)
    end
    
    within("#invoice-#{invoice3.id}") do
      expect(page).to have_link(invoice3.id)
    end
  end
end