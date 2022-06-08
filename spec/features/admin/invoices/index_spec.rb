require 'rails_helper'

RSpec.describe 'Admin Invoice Index Page' do
  before :each do
  @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka")
  @invoice_1 = @customer_1.invoices.create!(status: "cancelled")
  @invoice_2 = @customer_1.invoices.create!(status: "in progress")
  @invoice_3 = @customer_1.invoices.create!(status: "completed")
  end

  it "lists all invoice ID's and links to their show page", :vcr do
    visit admin_invoices_path
    expect(page).to have_content("Invoice ID's:")
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
    click_link "#{@invoice_1.id}"
    expect(current_path).to eq(admin_invoice_path(@invoice_1))
  end
end
