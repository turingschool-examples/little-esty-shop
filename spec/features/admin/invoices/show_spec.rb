require 'rails_helper'

RSpec.describe 'the admin invoice index' do
  before :each do
    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")

    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_3 = @customer_2.invoices.create!(status: "in progress")
    @invoice_4 = @customer_2.invoices.create!(status: "completed")
  end

  it "Invoice Information in show page" do
    visit "/admin/invoices/#{@invoice_1.id}"
save_and_open_page
    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@invoice_1.created_at.strftime("%A, %B %d, %Y")}")
    expect(page).to have_content("#{@customer_1.first_name}")
    expect(page).to have_content("#{@customer_1.last_name}")
  end

end
