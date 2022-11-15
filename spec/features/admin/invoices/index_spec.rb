require "rails_helper"

RSpec.describe "The Admin Invoices Index page" do
  before(:each) do
    customer = create(:customer)
    @invoice_1 = create(:invoice, customer: customer)
    @invoice_2 = create(:invoice, customer: customer)
    @invoice_3 = create(:invoice, customer: customer)

    visit admin_invoices_path
  end
  describe "As an admin, when I visit /admin/invoices" do
    it "displays a list of all Invoice ids in the system, each id links to the admin invoice show page" do
      within "#invoice-#{@invoice_1.id}" do
        expect(page).to have_link("Invoice ##{@invoice_1.id}", href: admin_invoice_path(@invoice_1))
      end

      within "#invoice-#{@invoice_2.id}" do
        expect(page).to have_link("Invoice ##{@invoice_2.id}", href: admin_invoice_path(@invoice_2))
      end

      within "#invoice-#{@invoice_3.id}" do
        expect(page).to have_link("Invoice ##{@invoice_3.id}", href: admin_invoice_path(@invoice_3))
      end

      click_on("Invoice ##{@invoice_3.id}")

      expect(current_path).to eq(admin_invoice_path(@invoice_3))
    end
  end
end