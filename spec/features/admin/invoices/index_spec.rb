require "rails_helper"

RSpec.describe "Admin Invoices Index", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @items = create_list(:item, 3, merchant: @merchant1)
    @customer1 = create(:customer)
    @invoices = create_list(:invoice, 3, customer: @customer1)
    @invoice_item1 = create(:invoice_item, invoice: @invoices.first, item: @items.first)
    @invoice_item2 = create(:invoice_item, invoice: @invoices.second, item: @items.second)
    @invoice_item3 = create(:invoice_item, invoice: @invoices.last, item: @items.last)
  end

  it "Has all invoice ids", :vcr do
    visit "/admin/invoices"

    within("#invoices") do
      within("#invoice-#{@invoices.first.id}") do
        expect(page).to have_content(@invoices.first.id)
        expect(page).to_not have_content(@invoices.second.id)
        expect(page).to_not have_content(@invoices.last.id)
      end
      within("#invoice-#{@invoices.second.id}") do
        expect(page).to have_content(@invoices.second.id)
        expect(page).to_not have_content(@invoices.first.id)
        expect(page).to_not have_content(@invoices.last.id)
      end
      within("#invoice-#{@invoices.last.id}") do
        expect(page).to have_content(@invoices.last.id)
        expect(page).to_not have_content(@invoices.first.id)
        expect(page).to_not have_content(@invoices.second.id)
      end
    end
  end

  it "Links from index to show page for each invoice", :vcr do
    visit "/admin/invoices"

    within("#invoices") do
      within("#invoice-#{@invoices.first.id}") do
        expect(page).to have_link(@invoices.first.id, href: "/admin/invoices/#{@invoices.first.id}")
        expect(page).to_not have_link(@invoices.second.id, href: "/admin/invoices/#{@invoices.second.id}")
        expect(page).to_not have_link(@invoices.last.id, href: "/admin/invoices/#{@invoices.last.id}")
      end
    end

    click_link(@invoices.first.id)

    expect(current_path).to eq("/admin/invoices/#{@invoices.first.id}")
  end
end
