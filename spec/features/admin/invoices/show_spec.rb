require "rails_helper"

RSpec.describe "Admin Invoice Show", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @items = create_list(:item, 4, merchant: @merchant1)
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @invoices1 = create_list(:invoice, 2, customer: @customer1)
    @invoices2 = create_list(:invoice, 2, customer: @customer2)
    @invoice_item1 = create(:invoice_item, invoice: @invoices1.first, item: @items.first)
    @invoice_item2 = create(:invoice_item, invoice: @invoices1.last, item: @items.second)
    @invoice_item3 = create(:invoice_item, invoice: @invoices2.first, item: @items.third)
    @invoice_item4 = create(:invoice_item, invoice: @invoices2.last, item: @items.last)
  end

  it "Shows the attributes for the selected invoice" do
    visit "/admin/invoices/#{@invoices1.first.id}"

    within("#invoice-info") do
      expect(page).to have_content(@invoices1.first.id)
      expect(page).to have_content(@invoices1.first.status)
      expect(page).to have_content(@invoices1.first.created_at.strftime("%A, %B %e, %Y"))
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
      expect(page).to_not have_content(@invoices2.second.id)
      expect(page).to_not have_content(@customer2.first_name)
      expect(page).to_not have_content(@customer2.last_name)
    end
  end
end
