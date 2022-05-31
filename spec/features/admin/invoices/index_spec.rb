require 'rails_helper'

RSpec.describe 'Admin Invoice Index Page' do
  before :each do
  @customer_1 = Customer.create!(first_name: 'Joey', last_name: "Ondricka", created_at: Time.now, updated_at: Time.now)
  @invoice_1 = @customer_1.invoices.create!(status: "cancelled", created_at: Time.now, updated_at: Time.now)
  @invoice_2 = @customer_1.invoices.create!(status: "in progress", created_at: Time.now, updated_at: Time.now)
  @invoice_3 = @customer_1.invoices.create!(status: "completed", created_at: Time.now, updated_at: Time.now)
  end

  it "lists all invoice ID's and links to their show page" do
    visit '/admin/invoices'
    expect(page).to have_content("Invoice ID's:")
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
    click_link "#{@invoice_1.id}"
    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
  end

end
