require 'rails_helper'

RSpec.describe "admin invoice index page" do
  before :each do
    @customer = Customer.create!(first_name: "First1", last_name: "Last1")

    @invoice1 = @customer.invoices.create!(status: 1)
    @invoice2 = @customer.invoices.create!(status: 1)
    @invoice3 = @customer.invoices.create!(status: 1)
    @invoice4 = @customer.invoices.create!(status: 2)


  end

  describe "when I visit the admin invoice index page" do
    it "shows a list off all the invioces, and each id links to that invoices show page" do
      visit "/admin/invoices"

      expect(page).to have_link("Invoice #{@invoice1.id}")
      expect(page).to have_link("Invoice #{@invoice2.id}")
      expect(page).to have_link("Invoice #{@invoice3.id}")
      expect(page).to have_link("Invoice #{@invoice4.id}")
    end
  end
end
