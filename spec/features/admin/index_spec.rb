require 'rails_helper'

RSpec.describe 'as an Admin' do
  describe 'when I visit the admin dashboard' do
    it "shows me a header indicating I'm on the admin dashboard" do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
    end

    it "shows me a link to the admin merchants index and I see a link to the admin invoices index" do
      visit '/admin'

      expect(page).to have_link("Admin Merchants Index")
      expect(page).to have_link("Admin Invoices Index")
    end
  end

  it 'shows a section for Incomplete Invoices with ids of invoices with non-shipped items as links' do
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)

    item1 = create(:item)
    item2 = create(:item)

    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, status: 0)
    invoice_item2 = create(:invoice_item, invoice: invoice2, item: item1, status: 1)
    invoice_item3 = create(:invoice_item, invoice: invoice3, item: item2, status: 2)

    visit '/admin'

    expect(page).to have_content(invoice1.id)
    expect(page).to have_content(invoice2.id)
    expect(page).not_to have_content(invoice3.id)
  end
end
