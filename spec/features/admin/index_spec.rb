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
    invoice1 = create(:invoice, customer: customer)
    invoice2 = create(:invoice, customer: customer)
    invoice3 = create(:invoice, customer: customer)
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, status: 0)
    invoice_item2 = create(:invoice_item, invoice: invoice1, item: item, status: 0)
    invoice_item3 = create(:invoice_item, invoice: invoice1, item: item, status: 2)
    invoice_item4 = create(:invoice_item, invoice: invoice2, item: item, status: 1)
    invoice_item5 = create(:invoice_item, invoice: invoice2, item: item, status: 1)
    invoice_item6 = create(:invoice_item, invoice: invoice2, item: item, status: 2)
    invoice_item7 = create(:invoice_item, invoice: invoice3, item: item, status: 2)
    invoice_item8 = create(:invoice_item, invoice: invoice3, item: item, status: 2)
    invoice_item9 = create(:invoice_item, invoice: invoice3, item: item, status: 2)

    visit admin_index_path

    expect(page).to have_content("Incomplete Invoices:")
    save_and_open_page
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
