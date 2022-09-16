require 'rails_helper'

describe 'the admin invoices index' do
  describe 'I see a list of all invoice ids and each id links to its show page' do
    it 'lists all invoice ids as links to the admin invoice show page' do
      5.times do
        create(:random_customer)
      end

      invoice_1 = create(:random_invoice, customer: Customer.all[0])
      invoice_2 = create(:random_invoice, customer: Customer.all[1])
      invoice_3 = create(:random_invoice, customer: Customer.all[2])
      invoice_4 = create(:random_invoice, customer: Customer.all[3])
      invoice_5 = create(:random_invoice, customer: Customer.all[4])
     
      visit admin_invoices_path

      expect(page).to have_link(invoice_1.id)
      expect(page).to have_link(invoice_2.id)
      expect(page).to have_link(invoice_3.id)
      expect(page).to have_link(invoice_4.id)
      expect(page).to have_link(invoice_5.id)

      click_link(invoice_1.id)

      expect(current_path).to eq(admin_invoice_path(invoice_1))
    end
  end
end