require 'rails_helper'

describe "the admin/invoices index page" do
  before (:each) do
    @customer1 = Customer.create(first_name: "John", last_name: "H")
    @invoice1 = @customer1.invoices.create(status: 0)
    @invoice2 = @customer1.invoices.create(status: 0)
    @invoice3 = @customer1.invoices.create(status: 1)
    visit "/admin/invoices"
  end

  describe "when I visit the admin/invoices index" do
    it "displays a list of all invoices" do

      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content(@invoice3.id)

    end

    it "has each name as a link to that show page" do

      click_on "#{@invoice1.id}"

      expect(current_path).to eq( "/admin/invoices/#{@invoice1.id}")
      expect(page).to have_content("Invoice id: #{@invoice1.id}")
    end
  end
end
