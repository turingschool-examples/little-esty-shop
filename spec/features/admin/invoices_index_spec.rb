require 'rails_helper'

RSpec.describe "Merchanct Invoices Index" do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @customer = create(:customer)
    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer.id)
    visit '/admin/invoices'
  end

  it "can see a list of all invoice ids in the system" do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_3.id)
  end

  it "each id links to the admin invoice show page" do
    expect(page).to have_link("#{@invoice_1.id}", href: "/admin/invoices/#{@invoice_1.id}")
  end
end
