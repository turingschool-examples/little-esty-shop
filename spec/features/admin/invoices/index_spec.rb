require "rails_helper"

RSpec.describe 'admin invoice index page' do
  before(:each) do
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer)
    @invoice_2 = create(:invoice, customer: @customer)
    @invoice_3 = create(:invoice, customer: @customer)
    @invoice_4 = create(:invoice, customer: @customer)
  end

  it 'shows all invoices and links to respective show page' do
    visit admin_invoices_path

    within('#invoice-ids') do
      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).to have_link("#{@invoice_4.id}")
    end

    click_link "#{@invoice_1.id}"

    expect(current_path).to eq(admin_invoice_path(@invoice_1))
  end

end
