require "rails_helper"

RSpec.describe "Admin Invoices Index", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @items = create_list(:item, 3, merchant: @merchant1)
    @customer1 = create(:customer)
    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice_item1 = create(:invoice_item, invoice: @invoices[0], item: @items[0])
    @invoice_item2 = create(:invoice_item, invoice: @invoices[1], item: @items[1])
    @invoice_item3 = create(:invoice_item, invoice: @invoices[2], item: @items[2])
  end

  it "Has all invoice ids", :vcr do
    visit admin_invoices_path

    within("#invoices") do
      within("#invoice-#{@invoices[0].id}") do
        expect(page).to have_content(@invoices[0].id)
        expect(page).to_not have_content(@invoices[1].id)
        expect(page).to_not have_content(@invoices[2].id)
      end
      within("#invoice-#{@invoices[1].id}") do
        expect(page).to have_content(@invoices[1].id)
        expect(page).to_not have_content(@invoices[0].id)
        expect(page).to_not have_content(@invoices[2].id)
      end
      within("#invoice-#{@invoices[2].id}") do
        expect(page).to have_content(@invoices[2].id)
        expect(page).to_not have_content(@invoices[0].id)
        expect(page).to_not have_content(@invoices[1].id)
      end
    end
  end

  it "Links from index to show page for each invoice", :vcr do
    visit admin_invoices_path

    within("#invoices") do
      within("#invoice-#{@invoices[0].id}") do
        expect(page).to have_link(@invoices[0].id, href: admin_invoice_path(@invoices[0]))
        expect(page).to_not have_link(@invoices[1].id, href: admin_invoice_path(@invoices[1]))
        expect(page).to_not have_link(@invoices[2].id, href: admin_invoice_path(@invoices[2]))
      end
    end

    click_link(@invoices[0].id)

    expect(current_path).to eq(admin_invoice_path(@invoices[0]))
  end
end
