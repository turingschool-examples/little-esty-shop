require "rails_helper"

RSpec.describe "Admin Invoice Show", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @items = create_list(:item, 4, merchant: @merchant1)
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @invoices1 = create(:invoice, customer: @customer1)
    @invoices2 = create(:invoice, customer: @customer2)
    @invoice_item1 = create(:invoice_item, invoice: @invoices1, item: @items.first)
    @invoice_item2 = create(:invoice_item, invoice: @invoices1, item: @items.second)
    @invoice_item3 = create(:invoice_item, invoice: @invoices2, item: @items.third)
    @invoice_item4 = create(:invoice_item, invoice: @invoices2, item: @items.last)
  end

  it "Shows the attributes for the selected invoice" do
    visit "/admin/invoices/#{@invoices1.id}"

    within("#invoice-info") do
      expect(page).to have_content(@invoices1.id)
      expect(page).to have_content(@invoices1.status)
      expect(page).to have_content(@invoices1.created_at.strftime("%A, %B %e, %Y"))
      expect(page).to have_content(@customer1.first_name)
      expect(page).to have_content(@customer1.last_name)
      expect(page).to_not have_content(@invoices2.id)
      expect(page).to_not have_content(@customer2.first_name)
      expect(page).to_not have_content(@customer2.last_name)
    end
  end

  it "Shows the attributes for the invoice items on the selected invoice" do
    visit "/admin/invoices/#{@invoices1.id}"

    within("#invoice_items-#{@invoice_item1.id}") do
      expect(page).to have_content(@items.first.name)
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item1.unit_price)
      expect(page).to have_content(@invoice_item1.status)
      expect(page).to_not have_content(@items.second.name)
    end

    within("#invoice_items-#{@invoice_item2.id}") do
      expect(page).to have_content(@items.second.name)
      expect(page).to have_content(@invoice_item2.quantity)
      expect(page).to have_content(@invoice_item2.unit_price)
      expect(page).to have_content(@invoice_item2.status)
      expect(page).to_not have_content(@items.first.name)
    end
  end
end
