require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do
  before (:each) do
    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id)
  end
  #User Story 33
  describe "Admin Invoices Index Page" do
    visit admin_invoices_path(@invoice_1)
    expect(page).to have_content("")
  end
end