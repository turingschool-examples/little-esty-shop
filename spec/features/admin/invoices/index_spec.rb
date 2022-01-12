require 'rails_helper'

RSpec.describe 'Admin Invoices Index page', type: :feature do

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2) {customer_1.invoices.create!(status: 1, created_at: '2012-03-28 12:54:09')}
  let!(:invoice_3) {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}

  before (:each) do
    visit admin_invoices_path
  end

  scenario 'admin sees list of all invoice ids in system' do
    expect(page).to have_content(invoice_1.id)
    expect(page).to have_content(invoice_2.id)
    expect(page).to have_content(invoice_3.id)
  end

  scenario 'each id links to admin invoice show page' do
    expect(page).to have_link("#{invoice_1.id}", href: admin_invoice_path(invoice_1.id))
    expect(page).to have_link("#{invoice_2.id}", href: admin_invoice_path(invoice_2.id))
    expect(page).to have_link("#{invoice_3.id}", href: admin_invoice_path(invoice_3.id))
  end
end
