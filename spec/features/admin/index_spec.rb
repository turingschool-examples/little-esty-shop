require "rails_helper"

RSpec.describe "Admin Dashboard (Index", type: :feature do
  
  before(:each) do
    @customer_1 = Customer.create!("Luke", "Harison")
    @customer_2 = Customer.create!("Angela", "Leizer")
    @customer_3 = Customer.create!("Matt", "Sorry")
    @customer_4 = Customer.create!("Drake", "Pointer")
    @customer_5 = Customer.create!("Fannie", "May")
    @customer_6 = Customer.create!("Lorelai", "Gillmore")
    @customer_7 = Customer.create!("Simon", "Garfunkle")

    @invoice_1 = @customer_1.invoice.create!(status: completed)
    @invoice_2 = @customer_1.invoice.create!(status: completed)
    @invoice_3 = @customer_1.invoice.create!(status: cancelled)
    @invoice_4 = @customer_1.invoice.create!(status: in_progress)
    @invoice_5 = @customer_1.invoice.create!(status: in_progress)
    @invoice_6 = @customer_2.invoice.create!(status: completed)
    @invoice_7 = @customer_2.invoice.create!(status: completed)
    @invoice_8 = @customer_3.invoice.create!(status: completed)
    @invoice_9 = @customer_3.invoice.create!(status: completed)
    @invoice_10 = @customer_3.invoice.create!(status: in_progress)
    @invoice_11 = @customer_3.invoice.create!(status: completed)
    @invoice_12 = @customer_4.invoice.create!(status: cancelled)
    @invoice_13 = @customer_4.invoice.create!(status: cancelled)
    @invoice_14 = @customer_4.invoice.create!(status: in_progress)
    @invoice_15 = @customer_5.invoice.create!(status: completed)
    @invoice_16 = @customer_5.invoice.create!(status: completed)
    @invoice_17 = @customer_6.invoice.create!(status: cancelled)
    @invoice_18 = @customer_6.invoice.create!(status: in_progress)
    @invoice_19 = @customer_6.invoice.create!(status: in_progress)
    @invoice_20 = @customer_7.invoice.create!(status: completed)
  end

  it "has a header indicating that the user is on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end

  it "has a link to the admin merchants index" do
    visit "/admin"
    expect(page).to have_link("Admin Merchants", href: "/admin/merchants")
  end

  it "has a link to the admin invoices index" do
    visit "/admin"
    expect(page).to have_link("Admin Invoices", href: "/admin/invoices")
  end

  it "has a list of the top 5 customers who have conducted the largest unmber of successful
    transactions" do
      visit "/admin"

  end

  it "next to each of the top 5 customers it has the number of successful transactions they
    have conducted" do
      visit "/admin"

  end

end