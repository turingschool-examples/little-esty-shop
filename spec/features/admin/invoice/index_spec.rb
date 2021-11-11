require 'rails_helper'

RSpec.describe 'the admin invoice index' do
  describe 'as an admin' do
    before :each do
      @customer = Customer.create(first_name: 'Taylor', last_name: 'Swift')
      @invoice_1 = @customer.invoices.create(status: 'in progress')
      @invoice_2 = @customer.invoices.create(status: 'cancelled')
      @invoice_3 = @customer.invoices.create(status: 'completed')
    end

    it 'I see a list of all Invoice ids in the system' do
      visit '/admin/invoices'

      expect(page).to have_content @invoice_1.id
      expect(page).to have_content @invoice_2.id
      expect(page).to have_content @invoice_3.id
    end

    it 'each id links to the admin invoice show page' do
      visit '/admin/invoices'

      click_on @invoice_1.id

      expect(current_path).to eq "/admin/invoices/#{@invoice_1.id}"
    end
  end
end
