require 'rails_helper'

RSpec.describe 'the admin show page' do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_3 = create(:invoice, customer: @customer_2)
    @invoice_4 = create(:invoice, customer: @customer_5)
    @invoice_5 = create(:invoice, customer: @customer_5)
  end

  describe 'As an admin, When I visit an admin invoice show page' do
    it 'shows the attributes for the corresponding invoice' do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.to_formatted_s(:admin_invoice_date))
      expect(page).to have_content(@invoice_1.customer.first_name)
      expect(page).to have_content(@invoice_1.customer.last_name)
    end
  end
end