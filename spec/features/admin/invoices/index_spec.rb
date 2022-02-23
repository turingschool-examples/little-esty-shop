require 'rails_helper'

RSpec.describe 'Admin Invoices Index' do
  describe 'user story #9' do
    before :each do
      @customer_1 = Customer.create!(first_name: "Paul", last_name: "Atreides")
      @customer_2 = Customer.create!(first_name: "Baron", last_name: "Harkonnen")
      @customer_3 = Customer.create!(first_name: "Reverend", last_name: "Mother")

      @invoice_1 = @customer_1.invoices.create!(created_at: '2012-03-25 09:54:09')
      @invoice_2 = @customer_2.invoices.create!(created_at: '2012-03-25 09:54:09')
      @invoice_3 = @customer_3.invoices.create!(created_at: '2012-03-25 09:54:09')
    end

    it "when visiting /admin/invoices I see all invoices as links to show pages" do
      visit admin_invoices_path

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_3.id)
    end

    it 'each id links to admin invoice show page' do
      visit admin_invoices_path

      expect(page).to have_link("#{@invoice_1.id}", href: admin_invoice_path(@invoice_1.id))
      expect(page).to have_link("#{@invoice_2.id}", href: admin_invoice_path(@invoice_2.id))
      expect(page).to have_link("#{@invoice_3.id}", href: admin_invoice_path(@invoice_3.id))
    end
  end
end
