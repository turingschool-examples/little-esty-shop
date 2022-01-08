require 'rails_helper'

RSpec.describe 'Admin Invoice Index page' do
  before(:each) do
    @cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")

    @invoice_1 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
    @invoice_2 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
    @invoice_3 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
  end


    it 'displays a list of all Invoice ids in the system' do
      visit admin_invoices_path

      within ".invoices" do
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_3.id)
      end
    end

  it 'links to admin invoice show page' do
    visit admin_invoices_path

    within ".invoices" do
      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")

      click_link("#{@invoice_1.id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end
  end
end
