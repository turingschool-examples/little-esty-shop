require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  it "shows admin dash header", :vcr do
    visit admin_index_path

    within("#admin-header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it "contains links to merchant and invoice admin views", :vcr do
    visit admin_index_path

    within("#dashboard-links") do
      expect(page).to have_link("Merchants View", href: admin_merchants_path)
      expect(page).to have_link("Invoices View", href: admin_invoices_path)
    end
  end

  it "has incomplete invoices section displaying their ids that link to those invoices", :vcr do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer, status: 0)
    invoice2 = create(:invoice, customer: customer, status: 1)
    invoice3 = create(:invoice, customer: customer, status: 2)

    visit admin_index_path

    expect(page).to have_content("Incomplete Invoices:")

    within("#incomplete-invoices-#{invoice1.id}") do
      expect(page).to have_content(invoice1.id.to_s)
      expect(page).to_not have_content(invoice2.id.to_s)
      expect(page).to_not have_content(invoice3.id.to_s)
      expect(page).to have_link(invoice1.id.to_s, href: admin_invoice_path(invoice1.id))
    end

    within("#incomplete-invoices-#{invoice2.id}") do
      expect(page).to have_content(invoice2.id.to_s)
      expect(page).to_not have_content(invoice1.id.to_s)
      expect(page).to_not have_content(invoice3.id.to_s)
      expect(page).to have_link(invoice2.id.to_s, href: admin_invoice_path(invoice2.id))
    end
  end
end
