require 'rails_helper'

RSpec.describe "Admin Invoice Page" do

  describe 'As an Admin' do

    before do
      @customer_1 = create(:customer)
      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: "2012-03-25 09:54:09 UTC")
      @customer_2 = create(:customer)
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: "2012-03-25 09:54:09 UTC")
      @customer_3 = create(:customer)
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: "2012-03-25 09:54:09 UTC")
      visit '/admin/invoices'
    end

    it'shows a list of all invoice ids as links to their respective show page'do
    save_and_open_page
    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_2.id}")
    expect(page).to have_content("#{@invoice_3.id}")
    end

  end
end
