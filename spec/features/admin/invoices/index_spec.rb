require 'rails_helper'

RSpec.describe 'the admin invoice index' do
  before :each do
    @customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")
    @customer_2 = Customer.create!(first_name: "Person 2", last_name: "Mcperson 2")
    @customer_3 = Customer.create!(first_name: "Person 3", last_name: "Mcperson 3")
    @customer_4 = Customer.create!(first_name: "Person 4", last_name: "Mcperson 4")
    @customer_5 = Customer.create!(first_name: "Person 5", last_name: "Mcperson 5")
    @customer_6 = Customer.create!(first_name: "Person 6", last_name: "Mcperson 6")

    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_1.invoices.create!(status: "cancelled")
    @invoice_3 = @customer_2.invoices.create!(status: "in progress")
    @invoice_4 = @customer_2.invoices.create!(status: "completed")
    @invoice_5 = @customer_2.invoices.create!(status: "cancelled")
    @invoice_6 = @customer_3.invoices.create!(status: "in progress")
    @invoice_7  = @customer_3.invoices.create!(status: "completed")
    @invoice_8 = @customer_3.invoices.create!(status: "cancelled")
    @invoice_9 = @customer_4.invoices.create!(status: "in progress")
    @invoice_10 = @customer_4.invoices.create!(status: "completed")
    @invoice_11 = @customer_5.invoices.create!(status: "cancelled")
    @invoice_12 = @customer_6.invoices.create!(status: "in progress")
  end

  it "Lists Invoice Id on index page" do
    visit '/admin/invoices'

    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_3.id}")
    expect(page).to have_content("#{@invoice_6.id}")
    expect(page).to have_content("#{@invoice_10.id}")
    expect(page).to have_content("#{@invoice_12.id}")
  end

  it "Invoice Id's are links to admin invoice show page" do
    visit '/admin/invoices'

    expect(page).to have_link("#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_12.id}")
  end

  it "Invoice Id's are links to admin invoice show page" do
    visit '/admin/invoices'

    expect(page).to have_link("#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_12.id}")
  end

  it "Has a show page" do
    visit '/admin/invoices'

    click_link("#{@invoice_1.id}")

    expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
  end
end
